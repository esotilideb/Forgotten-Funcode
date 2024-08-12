package states;

import flixel.graphics.FlxGraphic;
import sys.FileSystem;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
//import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;
import hxcodec.flixel.FlxVideo as VideoHandler;

using StringTools;

var pressEnter:FlxSprite;
var video:VideoHandler;

class Intro extends MusicBeatState
{
    override public function create()
    {
      Paths.clearStoredMemory();

      #if LUA_ALLOWED
      Mods.pushGlobalMods();
      #end
      Mods.loadTopMod();
  
      FlxG.fixedTimestep = false;
      FlxG.game.focusLostFramerate = 60;
      FlxG.keys.preventDefaultKeys = [TAB];
  
      super.create();
  
      FlxG.save.bind('funkin', CoolUtil.getSavePath());
  
      FlxG.mouse.visible = false;
      FlxG.sound.volume = 10;
      
      video = new VideoHandler();
      #if (hxCodec >= "3.0.0")
      // Recent versions
      video.play(Paths.video('cutscene_jam'));
      video.onEndReached.add(function()
      {
        video.dispose();
        LoadingState.loadAndSwitchState(new MainMenuState(), true);
        return;
      }, true);
      #else
      // Older versions
      video.playVideo(Paths.video('cutscene_jam'));
      video.finishCallback = function()
      {
        startAndEnd();
        return;
      }
      #end

      pressEnter = new FlxSprite(950, 600).loadGraphic(Paths.image('menu/enter'));
      pressEnter.antialiasing = ClientPrefs.data.antialiasing;
      pressEnter.alpha = 1;
      add(pressEnter);
      pressEnter.screenCenter();

      FlxTween.tween(pressEnter, {alpha:1}, 0.5, {ease: FlxEase.expoOut});
      }

      
	override function update(elapsed:Float)
    {
        if (controls.ACCEPT) {

          FlxG.camera.fade(FlxColor.BLACK, 1, false, null, true);
          new FlxTimer().start(1.1, function(tmr:FlxTimer)
            {
              video.dispose();
              LoadingState.loadAndSwitchState(new MainMenuState(), true);
            });

          FlxTween.tween(pressEnter, {alpha:0}, 0.5, {ease: FlxEase.expoOut});

        }
    }
}
