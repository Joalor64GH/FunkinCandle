package;

import hscript.*;

/**
 * Credit: MemeHoovy
 */
class ScriptThings
{
    var hornyParser:Parser = new Parser();
    
    public static inline function doParse(script:String, ?name:String){
        if (hornyParser != null)
            return hornyParser.parseString(script, name);
        else
            return null;
    }

    public static function stopParser(){
        hornyParser = null; // make the parser null so it stops
    }
}