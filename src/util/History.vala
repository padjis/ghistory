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

public class ghistory.Util.History : GLib.Object {

    string content = "";
    Array<Array<string>> contentAsArray;

    public Array<Array<string>> readHistory (string searchTerm) {
        contentAsArray= new Array<Array<string>> ();
        string[] args={"cat", GLib.Environment.get_home_dir ()+"/.bash_history"};
        string result= execute (args);
        if (result == null || result.length == 0)
            return contentAsArray;

        string getResult = result;
        content = result;
        string[] lines = getResult.split ("\n");
        for (int a = 0; a < lines.length; a++) {
            if (lines[a].length!=0 && lines[a].contains (searchTerm)) {
                string command="";
                string visible_command="";
                Array<string> aResult = new Array<string> ();
                command = lines[a];
                aResult.append_val ((a+1).to_string());
                if(command.size()>100){
                    visible_command=command.substring(0,100)+" ...";
                }else{
                    visible_command=command;
                }
                aResult.append_val (command);
                aResult.append_val (visible_command);
                contentAsArray.append_val (aResult);
            }
        }
        return contentAsArray;
    }

    public string execute (string[] args) {
        int exit_status = -1;

        string std_out, std_err;

        string[] spawn_args = args;
		string[] spawn_env = Environ.get ();

        try {
            Process.spawn_sync (null,spawn_args,spawn_env,SpawnFlags.SEARCH_PATH,
                                                  null,
                                                  out std_out,
                                                  out std_err,
                                                  out exit_status);

            if (exit_status != 0) {
                warning ("Error encountered while executing [" + args[0] + "]:\n" + std_err);
            }
        }
        catch (SpawnError e) {
            warning ("Error encountered while executing [" + args[0] + "]:\n" + std_err);
            return "<>1";
        }

        return std_out;
    }

    /*
    public static int main(string[] args){
        History history=new History();
        Array<Array<string>> result=history.readHistory("");
        for (int i = 0; i < result.length ; i++) {
            Array<string> aResult=result.index(i);
            for (int j = 0; j < aResult.length ; j++) {
                print ("%s", aResult.index (j));
                print ("\t");
            }
            print("\n");
        }
        return 0;
    }
     */
}
