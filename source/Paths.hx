package;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.Assets as OpenFlAssets;
import sys.io.File;
import sys.FileSystem;

class Paths
{
	inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end;

	public static var ignoreFolders:Array<String> = [
		'songs',
		'fonts',
		'images',
		'videos',
		'music',
		'sounds',
		'data'
	];

	public static var modFolders:Array<String> = [];

	public static function checkModFolders():Void
	{
		var path:Array<String> = FileSystem.readDirectory(FileSystem.absolutePath(mods('')));

		if (path != null)
			for (i in path)
				if (!ignoreFolders.contains(i))
					modFolders.push(i);
	}

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

    #if MODS
	inline static public function fromModFolders(file:String)
	{
		for (i in modFolders)
			if (FileSystem.exists('assets/mods/$i/$key'))
				return 'mods/$i/$key';

		return 'assets/mods/' + key;
	}
	#end

	inline static public function txt(key:String)
	{
		#if MODS
		return fromModFolders('data/$key.txt');
		#else
		return file('data/$key.txt');
		#end
	}

	inline static public function xml(key:String)
	{
		#if MODS
		return fromModFolders('data/$key.xml');
		#else
		return file('data/$key.xml');
		#end
	}

	inline static public function json(key:String)
	{
		#if MODS
		return fromModFolders('data/$key.json');
		#else
		return file('data/$key.json');
		#end
	}

	static public function sound(key:String)
	{
		#if MODS
		return fromModFolders('sounds/$key.$SOUND_EXT');
		#else
		return file('sounds/$key.$SOUND_EXT');
		#end
	}

	inline static public function soundRandom(key:String, min:Int, max:Int)
	{
		return sound(key + FlxG.random.int(min, max));
	}

	inline static public function music(key:String)
	{
		#if MODS
		return fromModFolders('music/$key.$SOUND_EXT');
		#else
		return file('music/$key.$SOUND_EXT');
		#end
	}

	inline static public function voices(song:String)
	{
		#if MODS
		return 'songs:assets/mods/songs/${song.toLowerCase()}/Voices.$SOUND_EXT';
		#else
		return 'songs:assets/songs/${song.toLowerCase()}/Voices.$SOUND_EXT';
		#end
	}

	inline static public function inst(song:String)
	{
		#if MODS
		return 'songs:assets/mods/songs/${song.toLowerCase()}/Inst.$SOUND_EXT';
		#else
		return 'songs:assets/songs/${song.toLowerCase()}/Inst.$SOUND_EXT';
		#end
	}

	inline static public function image(key:String)
	{
		#if MODS
		return fromModFolders('images/$key.png');
		#else
		return file('images/$key.png');
		#end
	}

	inline static public function video(key:String)
	{
		#if MODS
		return fromModFolders('videos/$key.mp4');
		#else
		return file('videos/$key.mp4');
		#end
	}

	inline static public function font(key:String)
	{
		#if MODS
		return 'assets/mods/fonts/$key';
		#else
		return 'assets/fonts/$key';
		#end
	}

	#if MODS
	inline static public function getModSparrowAtlas(key:String)
	{
		return FlxAtlasFrames.fromSparrow(image(key), fromModFolders('images/$key.xml'));
	}

	inline static public function getModPackerAtlas(key:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key), fromModFolders('images/$key.txt'));
	}
	#end

	inline static public function getSparrowAtlas(key:String)
	{
		return FlxAtlasFrames.fromSparrow(image(key), file('images/$key.xml'));
	}

	inline static public function getPackerAtlas(key:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key), file('images/$key.txt'));
	}
}
