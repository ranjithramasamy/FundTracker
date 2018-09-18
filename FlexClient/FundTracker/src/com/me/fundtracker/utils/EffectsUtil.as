package com.me.fundtracker.utils
{
	import mx.core.Application;
	import mx.core.FlexGlobals;
	import mx.core.IVisualElement;
	import mx.effects.Fade;
	import mx.effects.Move;
	import mx.effects.Parallel;

	public class EffectsUtil
	{
		/**
		 * Constants 
		 */		
		public static const DIRECTION_MOVE_LEFT : String = "left";
		public static const DIRECTION_MOVE_RIGHT : String = "right";
		
		/**
		 * Holds the current class instance. 
		 */		
		private static var _effectInstance : EffectsUtil;
		
		/**
		 * Single Instance of Our EffectsUtil 
		 * @param enforcer
		 * 
		 */		
		public function EffectsUtil( enforcer : SingletonEffectsUtil )
		{
			if (enforcer == null) {
				throw new Error( "You Can Only Have One ModelLocator" );
			}
		}
		
		/**
		 * Returns the Single Instance. 
		 * @return 
		 * 
		 */		
		public static function getInstance() : EffectsUtil
		{
			if (_effectInstance == null) {
				_effectInstance = new EffectsUtil( new SingletonEffectsUtil() );
			}
			
			return _effectInstance;
		}
		
		/**
		 * Animate the move with fade effect parallelly. 
		 * @param oldElement
		 * @param newElement
		 * @param direction
		 * 
		 */		
		public function playFadeWithMoveEffect( oldElement : IVisualElement, newElement : IVisualElement, direction : String ) : void
		{
			var objMove : Move = new Move();
			var objFade : Fade = new Fade(oldElement);
			var objParallel : Parallel = new Parallel();
			
			newElement.x = newElement.width;
			objMove.xFrom = FlexGlobals.topLevelApplication.width;
			objMove.xTo = 0;
			objMove.target = newElement;
			//objMove.play([newElement]);
			
			objFade.target = oldElement;
			objFade.alphaFrom = 1;
			objFade.alphaTo = 0;
			
			objParallel.addChild(objMove);
			objParallel.addChild(objFade)
			objParallel.play();
		}
	}
}

// -----------------------------------------------------------------------------------------------------------------------------------------
//					Internal class which is accessed by current class itself that are enforcing the strict Singleton model
// -----------------------------------------------------------------------------------------------------------------------------------------

class SingletonEffectsUtil {}