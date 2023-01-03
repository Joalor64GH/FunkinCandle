package;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;

class Paths
{
	inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end;

	static var currentLevel:String;

	static public function setCurrentLevel(name:String)
	{
		currentLevel = name.toLowerCase();
	}

	static function getPath(file:String, type:AssetType, library:Null<String>)
	{
		if (library != null)
			return getLibraryPath(file, library);

		if (currentLevel != null)
		{
			var levelPath = getLibraryPathForce(file, currentLevel);
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;

			levelPath = getLibraryPathForce(file, "shared");
			if (OpenFlAssets.exists(levelPath, type))
				return levelPath;
		}

		return getPreloadPath(file);
	}

	static public function getLibraryPath(file:String, library = "preload")
	{
		return if (library == "preload" || library == "default") getPreloadPath(file); else getLibraryPathForce(file, library);
	}

	inline static function getLibraryPathForce(file:String, library:String)
	{
		return '$library:assets/$library/$file';
	}

	inline static function getPreloadPath(file:String)
	{
		return 'assets/$file';
	}

	inline static public function file(file:String, type:AssetType = TEXT, ?library:String)
	{
		return getPath(file, type, library);
	}

    #if MODS
	inline static public function fromModFolders(file:String, ?mod:String)
	{
		return 'mods/$mod/$file';
	}

	inline static public function pack(file:String, ?mod:String)
	{
		return fromModFolders('pack.json');
	}

	inline static public function icon(file:String, ?mod:String)
	{
		return fromModFolders('pack.png');
	}
	#end

	inline static public function txt(key:String, ?library:String)
	{
		#if MODS
		return fromModFolders('data/$key.txt', TEXT, mod);
		#else
		return getPath('data/$key.txt', TEXT, library);
		#end
	}

	inline static public function xml(key:String, ?library:String)
	{
		#if MODS
		return fromModFolders('data/$key.xml', TEXT, library, mod);
		#else
		return getPath('data/$key.xml', TEXT, library);
		#end
	}

	inline static public function json(key:String, ?library:String)
	{
		#if MODS
		return fromModFolders('data/$key.json', TEXT, library, mod);
		#else
		return getPath('data/$key.json', TEXT, library);
		#end
	}

	static public function sound(key:String, ?library:String)
	{
		#if MODS
		return fromModFolders('sounds/$key.$SOUND_EXT', SOUND, mod);
		#else
		return getPath('sounds/$key.$SOUND_EXT', SOUND, library);
		#end
	}

	inline static public function soundRandom(key:String, min:Int, max:Int, ?library:String)
	{
		return sound(key + FlxG.random.int(min, max), library);
	}

	inline static public function music(key:String, ?library:String)
	{
		#if MODS
		return fromModFolders('music/$key.$SOUND_EXT', MUSIC, mod);
		#else
		return getPath('music/$key.$SOUND_EXT', MUSIC, library);
		#end
	}

	inline static public function voices(song:String)
	{
		#if MODS
		return 'songs:assets/mods/$mod/songs/${song.toLowerCase()}/Voices.$SOUND_EXT';
		#else
		return 'songs:assets/songs/${song.toLowerCase()}/Voices.$SOUND_EXT';
		#end
	}

	inline static public function inst(song:String)
	{
		#if MODS
		return 'songs:assets/mods/$mod/songs/${song.toLowerCase()}/Inst.$SOUND_EXT';
		#else
		return 'songs:assets/songs/${song.toLowerCase()}/Inst.$SOUND_EXT';
		#end
	}

	inline static public function image(key:String, ?library:String)
	{
		#if MODS
		return fromModFolders('images/$key.png', IMAGE, mod);
		#else
		return getPath('images/$key.png', IMAGE, library);
		#end
	}

	inline static public function video(key:String, ?library:String)
	{
		#if MODS
		return fromModFolders('videos/$key.mp4', mod);
		#else
		return getPath('videos/$key.mp4', library);
		#end
	}

	inline static public function font(key:String)
	{
		#if MODS
		return 'assets/mods/$mod/fonts/$key';
		#else
		return 'assets/fonts/$key';
		#end
	}

	#if MODS
	inline static public function getSparrowAtlas(key:String, ?mod:String)
	{
		return FlxAtlasFrames.fromSparrow(image(key, mod), file('images/$key.xml', mod));
	}

	inline static public function getPackerAtlas(key:String, ?mod:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key, mod), file('images/$key.txt', mod));
	}
	#end

	inline static public function getSparrowAtlas(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSparrow(image(key, library), file('images/$key.xml', library));
	}

	inline static public function getPackerAtlas(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key, library), file('images/$key.txt', library));
	}
}
