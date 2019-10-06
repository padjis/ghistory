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

public class ghistory.Application : Gtk.Application {

    public Application () {
        Object (
            application_id: "com.github.padjis.ghistory",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var window = new ghistory.Window (this);
        add_window (window);

        var provider = new Gtk.CssProvider ();
        provider.load_from_resource ("/com/github/padjis/ghistory/Application.css");
        Gtk.StyleContext.add_provider_for_screen (
            Gdk.Screen.get_default (),
            provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        );
    }
}
