package; // for advanced HScript I guess

import hscript.*;
import flixel.FlxG;
import ScriptThings;

class FunkinHscript extends Interp 
{
    var parser:Parser = new Parser();

    public function clearVariables(){
        variables.clear();
    }

    override public function get(varName:String):Dynamic {
        return variables.get(varName);
    }

    override public function set(varName:String, value:Dynamic):Dynamic {
        return variables.set(varName, value);
    }

    override public function exists(varName:String):Dynamic {
        return variables.exists(varName);
    }

    public static inline function parseScript(script:String, ?name:String):Dynamic {
        return ScriptThings.doParse(script, name);
    }

    public function new(){
        variables.set('Std', Std);
        variables.set('Type', Type);
        variables.set('Math', Math);
        variables.set('FlxG', FlxG);
        variables.set('Note', Note);
        variables.set('PlayState', PlayState);
        variables.set('CoolUtil', CoolUtil);
        variables.set('Date', Date);

        super();
    }
}