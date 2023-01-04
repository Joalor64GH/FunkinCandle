package;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.Assets as OpenFlAssets;

class Paths
{
	inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end;

	static var currentLevel:String;

	static public function setCurrentLevel(name:String)
	{
		currentLevel = name.toLowerCase();
	}

	static public function file(file:String)
	{
		var path = 'assets/$file';
		if (currentLevel != null && OpenFlAssets.exists('$currentLevel:$path'))
			return '$currentLevel:$path';

		return path;
	}

	inline static public function txt(key:String)
	{
		return file('data/$key.txt');
	}

	inline static public function xml(key:String)
	{
		return file('data/$key.xml');
	}

	inline static public function json(key:String)
	{
		return file('data/$key.json');
	}

	static public function sound(key:String)
	{
		return file('sounds/$key.$SOUND_EXT');
	}

	inline static public function soundRandom(key:String, min:Int, max:Int)
	{
		return sound(key + FlxG.random.int(min, max));
	}

	inline static public function music(key:String)
	{
		return file('music/$key.$SOUND_EXT');
	}

	inline static public function voices(song:String)
	{
		return 'songs:assets/songs/${song.toLowerCase()}/Voices.$SOUND_EXT';
	}

	inline static public function inst(song:String)
	{
		return 'songs:assets/songs/${song.toLowerCase()}/Inst.$SOUND_EXT';
	}

	inline static public function image(key:String)
	{
		return file('images/$key.png');
	}

	inline static public function video(key:String)
	{
		return file('videos/$key.mp4');
	}

	inline static public function font(key:String)
	{
		return 'assets/fonts/$key';
	}

	inline static public function getSparrowAtlas(key:String)
	{
		return FlxAtlasFrames.fromSparrow(image(key), file('images/$key.xml'));
	}

	inline static public function getPackerAtlas(key:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key), file('images/$key.txt'));
	}

	#if MODS
	inline static public function modFolder(file:String, mod:String)
	{
		var path = "";
		if (mod != null)
			path = 'assets/mods/$mod/$file';
		else
			path = 'assets/mods/$file';
		if (OpenFlAssets.exists(path))
			return path;

		return 'assets/mods';
	}

	inline static public function Modtxt(key:String, mod:String)
	{
		return modFolder('data/$key.txt', mod);
	}

	inline static public function Modxml(key:String, mod:String)
	{
		return modFolder('data/$key.xml', mod);
	}

	inline static public function Modjson(key:String, mod:String)
	{
		return modFolder('data/$key.json', mod);
	}

	static public function Modsound(key:String, mod:String)
	{
		return modFolder('sounds/$key.$SOUND_EXT', mod);
	}

	inline static public function soundRandom(key:String, min:Int, max:Int, mod:String)
	{
		return Modsound(key + FlxG.random.int(min, max), mod);
	}

	inline static public function Modmusic(key:String, mod:String)
	{
		return modFolder('music/$key.$SOUND_EXT', mod);
	}

	inline static public function Modvoices(song:String, mod:String)
	{
		return 'songs:assets/mods/$mod/songs/${song.toLowerCase()}/Voices.$SOUND_EXT';
	}

	inline static public function Modinst(song:String, mod:String)
	{
		return 'songs:assets/mods/$mod/songs/${song.toLowerCase()}/Inst.$SOUND_EXT';
	}

	inline static public function Modimage(key:String, mod:String)
	{
		return modFolder('images/$key.png', mod);
	}

	inline static public function Modvideo(key:String, mod:String)
	{
		return modFolder('videos/$key.mp4', mod);
	}

	inline static public function Modfont(key:String, mod:String)
	{
		return 'assets/mods/$mod/fonts/$key';
	}

	inline static public function getModSparrowAtlas(key:String, mod:String)
	{
		return FlxAtlasFrames.fromSparrow(Modimage(key, mod), modFolder('images/$key.xml', mod));
	}

	inline static public function getModPackerAtlas(key:String, mod:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(Modimage(key, mod), modFolder('images/$key.txt', mod));
	}
}