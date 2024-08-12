package states;

import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.text.FlxTypeText;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import options.OptionsState;
import backend.Song;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.7.3'; // This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	var optionShit:Array<String> = [
		'start',
		'credits',
		'talk',
		'options'
	];

	var pajasoOjitoWolso:FlxSprite; 
	var pajasoSilueta:FlxSprite;
	var pressEnter:FlxSprite;
	var dialogo:FlxSprite;

	var dialogoTexto:FlxText;
	var meloXD:String;

	var camFollow:FlxObject;
	var qDialogoPoner:Int = FlxG.random.int(0, 11);
	var qCancionPoner:Int = FlxG.random.int(0, 2);

	var enableControls:Bool = false;

	//never cook again
	var hasVsTricky:Bool;
	var hasVsImpostor:Bool;
	var canChooseDsides:Bool;
	var hasHazyRiver:Bool;
	var hasHotline024:Bool;
	var hasFunkedBirth:Bool;
	var hasSRUAI:Bool;
	var hasSONICEXE:Bool;
	var hasIndieCross:Bool;
	var hasOSM:Bool;
	var hasTrashcan:Bool;
	var hasDonkE:Bool;

	override function create()
	{
		#if MODS_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		chooseDialogue(false, false);

		if (ClientPrefs.data.alrBeatPiero)	FlxG.sound.playMusic(Paths.music('menu post cancion'), 1, true);
		else 								FlxG.sound.playMusic(Paths.music('menu'), 1, true);

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menu/bg'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		//bg.scrollFactor.set();
		bg.screenCenter();
		add(bg);

		var remolinoFondo = new FlxSprite();
		remolinoFondo.frames = Paths.getSparrowAtlas('menu/remolinofondo');
		//remolinoFondo.scrollFactor.set(0);
		remolinoFondo.screenCenter();
		remolinoFondo.antialiasing = false;
		remolinoFondo.animation.addByPrefix('idle', 'remolicocosa export', 24, true);			remolinoFondo.animation.play('idle');
		add(remolinoFondo);	

		pajasoSilueta = new FlxSprite();
		pajasoSilueta.frames = Paths.getSparrowAtlas('menu/menusilueta');
		//pajasoSilueta.scrollFactor.set(0);
		pajasoSilueta.screenCenter();
		pajasoSilueta.antialiasing = false;
		pajasoSilueta.animation.addByPrefix('idle', 'silueta', 24, true);
		pajasoSilueta.animation.addByPrefix('talk', 'silueta talking', 24, true);
		pajasoSilueta.animation.play('idle');
		add(pajasoSilueta);	

		var pajasoManitas = new FlxSprite();
		pajasoManitas.frames = Paths.getSparrowAtlas('menu/pasaselda');
		//pajasoManitas.scrollFactor.set(0);
		pajasoManitas.screenCenter();
		pajasoManitas.antialiasing = false;
		pajasoManitas.animation.addByPrefix('idle', 'selda vvvv', 24, true);			pajasoManitas.animation.play('idle');
		add(pajasoManitas);	

		pajasoOjitoWolso = new FlxSprite(500,200).loadGraphic(Paths.image('menu/ojito wholsom'));
		pajasoOjitoWolso.antialiasing = ClientPrefs.data.antialiasing;
		add(pajasoOjitoWolso);

		var barritas:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menu/barras_hotl'));
		barritas.antialiasing = ClientPrefs.data.antialiasing;
		barritas.screenCenter();
		add(barritas);

		dialogo  = new FlxSprite();
		dialogo.frames = Paths.getSparrowAtlas('menu/persona5');
		dialogo.screenCenter();
		dialogo.y += 50;
		dialogo.visible = false;
		dialogo.antialiasing = false;
		dialogo.animation.addByPrefix('when apareces', 'persona5spawn', 24, true);
		dialogo.animation.addByPrefix('idle', 'persona5box', 24, true);
		dialogo.animation.play('idle');
		add(dialogo);	

		dialogo.animation.callback = function(name:String, _, _) {
			switch(name) {
				case 'when apareces': dialogo.offset.set(20, -5);
				case 'idle': 		  dialogo.offset.set(0, -100);
			}
		}

		dialogoTexto = new FlxText(dialogo.x + 100, dialogo.y + 200, 1000, "Lets see... " + meloXD, 30);
		dialogoTexto.setFormat(Paths.font("Fontsona.ttf"), 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		dialogoTexto.borderSize = 1.25;
		dialogoTexto.alpha = 0;
		add(dialogoTexto);

		pressEnter = new FlxSprite(950, 600).loadGraphic(Paths.image('menu/enter'));
		pressEnter.antialiasing = ClientPrefs.data.antialiasing;
		pressEnter.alpha = 0;
		add(pressEnter);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(0, (i * 140) + offset);
			menuItem.antialiasing = ClientPrefs.data.antialiasing;
			menuItem.ID = i;
			menuItem.frames = Paths.getSparrowAtlas('menu/botones/' + optionShit[i] + 'boton');
			menuItem.animation.addByPrefix('idle', optionShit[i] + " static", 24);
			menuItem.animation.addByPrefix('hover', optionShit[i] + " selected", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " pushed", 24);
			menuItem.animation.play('idle');
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if (optionShit.length < 6)
				scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.updateHitbox();
			switch (i)
			{
				case 0: //start
					menuItem.setPosition(25, -50);
				case 1: //credits
					menuItem.setPosition(300, 0);
				case 2: //talk
					menuItem.setPosition(700, 325);
				case 3: //options
					menuItem.setPosition(850, -350);
			}
		}
		changeItem();

		super.create();

		FlxG.mouse.visible = true;
	}

	var selectedSomethin:Bool = false;
	var usingMouse:Bool = false;
	var canPlaySound:Bool;

	override function update(elapsed:Float)
	{
		dialogoTexto.text = "Lets see... " + meloXD;

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * elapsed;
			if (FreeplayState.vocals != null)
				FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		if (enableControls) {
			if (controls.ACCEPT) {
				selectedSomethin = false;
				FlxG.sound.play(Paths.sound('select'));

				menuItems.forEach(function(spr:FlxSprite)
					{
						FlxTween.tween(spr, {alpha:1}, 0.5, {ease: FlxEase.expoOut});	
					});

				FlxTween.tween(dialogo, {alpha:0}, 0.075, {ease: FlxEase.expoOut});
				FlxTween.tween(dialogoTexto, {alpha:0}, 0.075, {ease: FlxEase.expoOut});
				FlxTween.tween(pressEnter, {alpha:0}, 0.5, {ease: FlxEase.expoOut});

			}
		}

		if (FlxG.keys.justPressed.ONE){
			if (!ClientPrefs.data.alrBeatPiero)
				ClientPrefs.data.alrBeatPiero = true;
			else
				ClientPrefs.data.alrBeatPiero = false;

			trace("Ya venciste piero: " + ClientPrefs.data.alrBeatPiero);

		}else if (FlxG.keys.justPressed.TWO){
			if (!ClientPrefs.data.alrBeatPiero2)
				ClientPrefs.data.alrBeatPiero2 = true;
			else
				ClientPrefs.data.alrBeatPiero2 = false;

			trace("Ya venciste piero 2: " + ClientPrefs.data.alrBeatPiero2);
			
		}else if (FlxG.keys.justPressed.THREE){
			if (!ClientPrefs.data.alrBeatPieroD)
				ClientPrefs.data.alrBeatPieroD = true;
			else
				ClientPrefs.data.alrBeatPieroD = false;

			trace("Ya venciste piero d: " + ClientPrefs.data.alrBeatPieroD);
		}else if (FlxG.keys.justPressed.FOUR){
			LoadingState.loadAndSwitchState(new FreeplayState(), true);
		}


		if (!selectedSomethin)
		{

			menuItems.forEach(function(spr:FlxSprite)
				{
					if (usingMouse)
					{
						if (!FlxG.mouse.overlaps(spr)) 
							spr.animation.play('idle');
					}
	
					if (FlxG.mouse.overlaps(spr))
					{
							curSelected = spr.ID;
							usingMouse = true;
							menuItems.members[curSelected].animation.play('hover');
	
						if (FlxG.mouse.pressed) selectSomething(); //startDialogueToSong();
					}
					else	
						if (usingMouse)	{ 
							spr.animation.play('idle'); 
						}

					spr.updateHitbox();
				});
		}

		FlxG.camera.scroll.x = FlxMath.lerp(FlxG.camera.scroll.x, (FlxG.mouse.screenX-(FlxG.width/2)) * 0.008, (1/30)*240*elapsed);
		FlxG.camera.scroll.y = FlxMath.lerp(FlxG.camera.scroll.y, (FlxG.mouse.screenY-6-(FlxG.height/2)) * 0.008, (1/30)*240*elapsed);

		super.update(elapsed);
	}

	function selectSomething()
		{
			selectedSomethin = true;
			FlxG.sound.play(Paths.sound('select'));

			menuItems.forEach(function(spr:FlxSprite)
			{
				menuItems.members[curSelected].animation.play('selected');

					trace(optionShit[curSelected]);
					new FlxTimer().start(1.5, function(tmr:FlxTimer)
					{
						switch (optionShit[curSelected])
						{
								case 'start':
									if (ClientPrefs.data.alrBeatPiero && ClientPrefs.data.alrBeatPiero2 && ClientPrefs.data.alrBeatPieroD) {
										LoadingState.loadAndSwitchState(new FreeplayState(), true);
									}
									else {

										if (ClientPrefs.data.alrBeatPiero) PlayState.storyPlaylist = ['Piero-2'];
										else if (ClientPrefs.data.alrBeatPiero &&ClientPrefs.data.alrBeatPiero2) {
											if (canChooseDsides) PlayState.storyPlaylist = ['Piero-D'];
											else {
												switch (qCancionPoner) {
													case 0:
														PlayState.storyPlaylist = ['Piero'];
													case 1:
														PlayState.storyPlaylist = ['Piero-2'];
													case 2:
														PlayState.storyPlaylist = ['Piero-2'];
												}	
											}
										}
										else PlayState.storyPlaylist = ['Piero'];
		
										PlayState.isStoryMode = true;
										PlayState.campaignScore = 0;
										PlayState.campaignMisses = 0;
										PlayState.SONG = Song.loadFromJson(StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase(), StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase());        
										PlayState.storyDifficulty = 1;
										new FlxTimer().start(.1, function(tmr:FlxTimer)
											{
												LoadingState.loadAndSwitchState(new PlayState(), true);
												FreeplayState.destroyFreeplayVocals();
											});

											trace(qCancionPoner + " (" + PlayState.storyPlaylist + ")");
									}

								case 'credits':
									MusicBeatState.switchState(new CreditsState());
								case 'options':
									MusicBeatState.switchState(new OptionsState());
									OptionsState.onPlayState = false;
									if (PlayState.SONG != null)
									{
										PlayState.SONG.arrowSkin = null;
										PlayState.SONG.splashSkin = null;
										PlayState.stageUI = 'normal';
									}
								case 'talk':
									chooseDialogue(true, true);
						}
					});
			});
		}

		function chooseDialogue(shouldReroll:Bool = false, isMenuOption:Bool = false)
		{
			var appDataPath = Sys.getEnv("APPDATA");
			trace("AppData path: " + appDataPath);
	
			trace(qDialogoPoner);
			
			var mainTargetPath = appDataPath + "/ShadowMario";

			if (shouldReroll) qDialogoPoner = FlxG.random.int(0, 11);
	
			hasVsTricky = FileSystem.exists(""+appDataPath +'/kadedev/Vs. Tricky');
			hasVsImpostor = FileSystem.exists(""+appDataPath +"/ShadowMario/VS Impostor");
			canChooseDsides = FileSystem.exists(""+appDataPath +"/Team Deez");
			hasHazyRiver = FileSystem.exists(""+appDataPath +"/ShadowMario/HAZYRIVER");
			hasHotline024 = FileSystem.exists(""+appDataPath +"/Hotline024/Hotline024");
			hasFunkedBirth = FileSystem.exists(""+appDataPath +"/elfb34/FunkedBirth");
			hasSRUAI = FileSystem.exists(""+appDataPath +"/BreezyMelee/SRUAI");
			hasSONICEXE = FileSystem.exists(""+appDataPath +"/kadedev/Sonic");
			hasIndieCross = FileSystem.exists(""+appDataPath +"/Team 375/Indie Cross");
			hasOSM = FileSystem.exists(""+appDataPath +"/SugarMoon/Ena") || FileSystem.exists(""+appDataPath +"/SugarMoon/Mania");
			hasTrashcan = FileSystem.exists(""+appDataPath +"/ShadowMario/Trashcan");
			hasDonkE = FileSystem.exists(""+appDataPath +"/ShadowMario/Trashcan");
	
			if (FileSystem.exists(mainTargetPath) && FileSystem.isDirectory(mainTargetPath)) {
				var files = FileSystem.readDirectory(mainTargetPath);
				for (file in files) {
	
					var filePath = mainTargetPath + "/" + file;
					if (FileSystem.isDirectory(filePath)) {

						if (hasVsTricky == hasVsImpostor == canChooseDsides == hasHazyRiver == hasHotline024 == hasFunkedBirth == hasSRUAI == hasSONICEXE == hasIndieCross == hasOSM == hasTrashcan == hasDonkE == false) {
							meloXD = 'Woooow am i really the first guy you ever played with? Awwww… how sweet… but that also means i dont have stuff to tell you, go and download some mods kid, thats my whole gimmick yknow?';
						}
						else {
							if (qDialogoPoner == 0) {
								if (FileSystem.exists(""+appDataPath +'/kadedev/Vs. Tricky')) // si toda la culpa fue el \ me voy a matar
									meloXD = ' "Vs. Tricky"...  If clowns are good on something, is optimization, something mister 11000px x 11000px over there wouldnt get it';
								else qDialogoPoner = FlxG.random.int(0, 11);
							}
		
							if (qDialogoPoner == 1) {
								if (FileSystem.exists(""+appDataPath +"/ShadowMario/VS Impostor"))
									meloXD = '"Vs. Impostor"...  Have you beaten defeat yet? No? Then stop wasting my time';
								else qDialogoPoner = FlxG.random.int(0, 11);
							}
					
							if (qDialogoPoner == 2) {
								if (FileSystem.exists(""+appDataPath +"/Team Deez")) //solo cache que esto esta bien
									meloXD = '"D-Sides"...  Variation is great isnt it? Although i dont think i like that purple rascal a lot';
								else qDialogoPoner = FlxG.random.int(0, 11);
							}
							if (qDialogoPoner == 3) {
								if (FileSystem.exists(""+appDataPath +"/ShadowMario/HAZYRIVER"))
									meloXD = '"Hazy River"...  a little birdie told me you can actually save the green haired guy if you point a gun to your head, maybe you should try that out';
								else qDialogoPoner = FlxG.random.int(0, 11);
							}
					
							if (qDialogoPoner == 4) {
								if (FileSystem.exists(""+appDataPath +"/Hotline024/Hotline024"))
									meloXD = '"Hotline 024"... I bet you are also excited for sakura mix! Now what the hell is a sakura mix i wonder…';
								else qDialogoPoner = FlxG.random.int(0, 11);
							}
					
							if (qDialogoPoner == 5) {
								if (FileSystem.exists(""+appDataPath +"/elfb34/FunkedBirth"))
									meloXD = '"Funked Birth"...  Oh? Jesus? Like, from the bible? Isnt the world full of little surprises…';
								else qDialogoPoner = FlxG.random.int(0, 11);
							}
							if (qDialogoPoner == 6) {
								if (FileSystem.exists(""+appDataPath +"/BreezyMelee/SRUAI"))
									meloXD = '"Step Right Up: Adventure Isle"...  Adventure island, what a lovely place Too bad is not as lovely as my little jai puhuhuhu';
								else qDialogoPoner = FlxG.random.int(0, 11);
							}
		
							if (qDialogoPoner == 7)  {
								if (FileSystem.exists(""+appDataPath +"/kadedev/Sonic")) 
									meloXD = '"Sonic.EXE"...  I have to admit, that black eyed blue rat knows how to mess with people, although i wouldnt call him the best at it puhuhuhu';
								else qDialogoPoner = FlxG.random.int(0, 11);
							}
		
							if (qDialogoPoner == 8) {
								if (FileSystem.exists(""+appDataPath +"/Team 375/Indie Cross")) 
									meloXD = '"Indie Cross"...  Im not too fond of parallel universes actually, but seeing you getting humiliated by that cuphead guy was really funny';
								else qDialogoPoner = FlxG.random.int(0, 11);
							}
				
							if (qDialogoPoner == 9) {
								if (FileSystem.exists(""+appDataPath +"/SugarMoon/Ena") || FileSystem.exists(""+appDataPath +"/SugarMoon/Mania"))
									meloXD = '"One Shot Mania"...  I see you really like variety huh? So sad the best experiences are always so short…';
								else qDialogoPoner = FlxG.random.int(0, 11);
							}	
		
							if (qDialogoPoner == 10) {
								if (FileSystem.exists(""+appDataPath +"/ShadowMario/Trashcan"))
									meloXD = '"Funkin Trashcan"...  Oh i miss that little trash bin guy that used to work here, i wonder what hes up to now… maybe i’ll visit him soon… very very soon…';
								else qDialogoPoner = FlxG.random.int(0, 11);
							}
		
							if (qDialogoPoner == 11) {
								if (FileSystem.exists(""+appDataPath +"/kadedev/VSDonkE"))
									meloXD = '"Vs DonkE"...  Donk E? That guy is banned from the park, dont ask';
								else qDialogoPoner = FlxG.random.int(0, 11);
							}
						}

						if (isMenuOption) startDialogue();

					}
				}
			} else {
				trace("La carpeta no existe o no es un directorio.");
			}	
		}

		function startDialogueToSong()
			{
				FlxG.sound.play(Paths.sound('select'));
				menuItems.members[curSelected].animation.play('selected');
				selectedSomethin = true;

				new FlxTimer().start(1.5, function(tmr:FlxTimer)
					{
						menuItems.forEach(function(spr:FlxSprite)
							{
								FlxTween.tween(spr, {alpha:0}, 0.5, {ease: FlxEase.expoOut});	
							});

							FlxTween.tween(dialogo, {alpha:1}, 0.075, {ease: FlxEase.expoOut});	
							dialogo.animation.play('when apareces');
							
							new FlxTimer().start(0.5, function(tmr:FlxTimer)
								{
									dialogo.animation.play('idle');
									pajasoSilueta.animation.play('talk');
									FlxTween.tween(dialogoTexto, {alpha:1}, 0.075, {ease: FlxEase.expoOut});	
								});
					});

			}

			function startDialogue()
				{
					menuItems.members[curSelected].animation.play('selected');
					selectedSomethin = true;
	
					new FlxTimer().start(1.5, function(tmr:FlxTimer)
						{
							menuItems.forEach(function(spr:FlxSprite)
								{
									FlxTween.tween(spr, {alpha:0}, 0.5, {ease: FlxEase.expoOut});	
								});
	
								dialogo.alpha = 1;
								dialogo.visible = true;
								dialogo.animation.play('when apareces');
								
								
								new FlxTimer().start(0.5, function(tmr:FlxTimer)
									{
										dialogo.animation.play('idle');
										pajasoSilueta.animation.play('talk');
										FlxTween.tween(dialogoTexto, {alpha:1}, 0.075, {ease: FlxEase.expoOut});	
										enableControls = true;

										FlxTween.tween(pressEnter, {alpha:1}, 0.5, {ease: FlxEase.expoOut});
									});
						});
	
				}

	function changeItem(huh:Int = 0)
	{
		menuItems.members[curSelected].animation.play('idle');
		menuItems.members[curSelected].updateHitbox();

		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;
	}
}
