/*
 *  Copyright (C) 2019 Emmanuel Padjinou
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 *  Authored by: Emmanuel Padjinou <emmanuel@padjinou.com>
 *
 */

using ghistory.Widgets;
using Gtk;
using ghistory.Util;

public class ghistory.Window : ApplicationWindow {

    Array<Array<string>> data;
    Gtk.Label label;

    Gdk.Display display;
    Gtk.Clipboard clipboard;

	enum Column {
        INDEX,
        VISIBLE_CONTENT,
		CONTENT
	}

    private ghistory.Widgets.HeaderBar headerbar;

    string copied;
    string an_index;
    string a_content;
    string a_visible_content;

    public Window (Application application) {
        Object (
            application: application,
            resizable: false
        );
        display = Gdk.Display.get_default ();
        clipboard = Gtk.Clipboard.get_for_display (display, Gdk.SELECTION_CLIPBOARD);
    }

    construct {
        title = "Ghistory";
        window_position = WindowPosition.CENTER;
        set_default_size (575, 200);
        set_border_width (10);

        this.headerbar = new ghistory.Widgets.HeaderBar ();
        this.headerbar.history_refresh.connect (reset);
        this.set_titlebar (this.headerbar);

        Gtk.Box box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        
        var view = new Gtk.TreeView ();
		this.setup_treeview (view);
        view.expand = true;
        view.activate_on_single_click=false;

		label = new Gtk.Label ("");

		var grid = new Gtk.Grid ();

		grid.attach (view, 0, 0, 1, 1);
		grid.attach (label, 0, 1, 1, 1);
		this.add (grid);

		var selection = view.get_selection ();
        selection.changed.connect (this.on_changed);
        view.row_activated.connect (this.row_activated);

        box.pack_start (view, false, false, 0);

        add (box);

        show_all ();
    }

    private void refreshData(){
        History history=new History();
        Array<Array<string>> result = history.readHistory ("");
        data= new Array<Array<string>> ();

        uint limit=20;
        if(result.length<limit)
            limit=result.length;

        for (int i = 0; i < limit ; i++) {
            uint position=result.length-(limit-i);
            Array<string> aResult = new Array<string> ();
            aResult.append_val (result.index (position).index (0));
            aResult.append_val (result.index (position).index (1));
            aResult.append_val (result.index (position).index (2));
            data.append_val (aResult);
        }

    }

    void setup_treeview (Gtk.TreeView view) {
        refreshData();
        var listmodel = new Gtk.ListStore (3, typeof (string),
                                              typeof (string),
                                              typeof (string));
		view.set_model (listmodel);

		var cell = new Gtk.CellRendererText ();

		/* 'weight' refers to font boldness.
		 *  400 is normal.
		 *  700 is bold.
		 */
		cell.set ("weight_set", true);
		cell.set ("weight", 700);

		/*columns*/
		view.insert_column_with_attributes (-1, "Line",
                                                cell, "text",
                                                Column.INDEX);

		view.insert_column_with_attributes (-1, "Command",
                                                new Gtk.CellRendererText (),
                                                "text", Column.VISIBLE_CONTENT);

		/* Insert the data into the ListStore */
		Gtk.TreeIter iter;
		for (int i = 0; i < data.length; i++) {
			listmodel.append (out iter);
			listmodel.set (iter, Column.INDEX,
                                 data.index(i).index(0),
                                 Column.CONTENT, data.index(i).index(1)
                                 ,
                                 Column.VISIBLE_CONTENT, data.index(i).index(2));
		}
	}

	void on_changed (Gtk.TreeSelection selection) {
		Gtk.TreeModel model;
		Gtk.TreeIter iter;
        
		if (selection.get_selected (out model, out iter)) {
			model.get (iter,
                                   Column.INDEX, out an_index,
                                   Column.CONTENT, out a_content,
                                   Column.VISIBLE_CONTENT, out a_visible_content);
            
            copied=an_index;
			label.set_text ("\n Double-click to copy : " + a_visible_content );
		}
	}

    void row_activated () {
        if(copied!=null && copied.len()==an_index.len() && copied.contains(an_index)){
            clipboard.set_text(a_content,-1);
            close();
        }
	}

    public void reset () {
        close ();
        application.activate ();
    }
}
