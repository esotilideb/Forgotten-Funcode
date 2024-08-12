package backend;

class Highscore
{
	public static var weekScores:Map<String, Int> = new Map();

	public static var songScores:Map<String, Int> = new Map<String, Int>();
	public static var songMisses:Map<String, Int> = new Map<String, Int>();
	public static var songRating:Map<String, Float> = new Map<String, Float>();
	public static var songFC:Map<String, String> = new Map<String, String>();

	public static function resetSong(song:String, diff:Int = 0):Void
	{
		var daSong:String = formatSong(song, diff);
		setScore(daSong, 0);
		setMisses(daSong, 0);
		setRating(daSong, 0);
		setFC(daSong, '');
	}

	public static function resetWeek(week:String, diff:Int = 0):Void
	{
		var daWeek:String = formatSong(week, diff);
		setWeekScore(daWeek, 0);
	}

	public static function saveScore(song:String, score:Int = 0, misses:Int = 0, isFC:String = "", ?diff:Int = 0, ?rating:Float = -1):Void
	{
		var daSong:String = formatSong(song, diff);

		if (songScores.exists(daSong)) {
			if (songScores.get(daSong) < score) {
				setScore(daSong, score);
				if(misses >= 0) setMisses(daSong, misses);
				if(rating >= 0) setRating(daSong, rating);
				setFC(daSong, isFC);
			}
		}
		else {
			setScore(daSong, score);
			if(misses >= 0) setMisses(daSong, misses);
			if(rating >= 0) setRating(daSong, rating);
		}
	}

	public static function saveWeekScore(week:String, score:Int = 0, ?diff:Int = 0):Void
	{
		var daWeek:String = formatSong(week, diff);

		if (weekScores.exists(daWeek))
		{
			if (weekScores.get(daWeek) < score)
				setWeekScore(daWeek, score);
		}
		else
			setWeekScore(daWeek, score);
	}

	/**
	 * YOU SHOULD FORMAT SONG WITH formatSong() BEFORE TOSSING IN SONG VARIABLE
	 */
	static function setScore(song:String, score:Int):Void
	{
		// Reminder that I don't need to format this song, it should come formatted!
		songScores.set(song, score);
		FlxG.save.data.songScores = songScores;
		FlxG.save.flush();
	}

	static function setMisses(song:String, misses:Int):Void
	{
		// Reminder that I don't need to format this song, it should come formatted!
		songMisses.set(song, misses);
		FlxG.save.data.songMisses = songMisses;
		FlxG.save.flush();
	}

	static function setRating(song:String, rating:Float):Void
	{
		// Reminder that I don't need to format this song, it should come formatted!
		songRating.set(song, rating);
		FlxG.save.data.songRating = songRating;
		FlxG.save.flush();
	}

	static function setFC(song:String, isFC:String):Void
	{
		// Reminder that I don't need to format this song, it should come formatted!
		songFC.set(song, isFC);
		FlxG.save.data.songFC = songFC;
		FlxG.save.flush();
	}
	

	static function setWeekScore(week:String, score:Int):Void
		{
			// Reminder that I don't need to format this song, it should come formatted!
			weekScores.set(week, score);
			FlxG.save.data.weekScores = weekScores;
			FlxG.save.flush();
		}

	public static function formatSong(song:String, diff:Int):String
	{
		return Paths.formatToSongPath(song) + Difficulty.getFilePath(diff);
	}

	public static function getScore(song:String, diff:Int):Int
	{
		var daSong:String = formatSong(song, diff);
		if (!songScores.exists(daSong))
			setScore(daSong, 0);

		return songScores.get(daSong);
	}

	public static function getMisses(song:String, diff:Int):Int
		{
			var daSong:String = formatSong(song, diff);
			if (!songScores.exists(daSong))
				setMisses(daSong, 0);
	
			return songMisses.get(daSong);
		}

	public static function getRating(song:String, diff:Int):Float
	{
		var daSong:String = formatSong(song, diff);
		if (!songRating.exists(daSong))
			setRating(daSong, 0);

		return songRating.get(daSong);
	}

	public static function getFC(song:String, diff:Int):String
	{
		var daSong:String = formatSong(song, diff);
		if (!songFC.exists(daSong))
			setFC(daSong, "");

			return songFC.get(daSong);
	}

	public static function getWeekScore(week:String, diff:Int):Int
	{
		var daWeek:String = formatSong(week, diff);
		if (!weekScores.exists(daWeek))
			setWeekScore(daWeek, 0);

		return weekScores.get(daWeek);
	}

	public static function load():Void
	{
		if (FlxG.save.data.weekScores != null)
		{
			weekScores = FlxG.save.data.weekScores;
		}
		if (FlxG.save.data.songScores != null)
		{
			songScores = FlxG.save.data.songScores;
		}
		if (FlxG.save.data.songMisses != null)
			{
				songMisses = FlxG.save.data.songMisses;
			}
		if (FlxG.save.data.songRating != null)
		{
			songRating = FlxG.save.data.songRating;
		}
		if (FlxG.save.data.songFC != null)
		{
			songFC = FlxG.save.data.songFC;
		}
	}
}