package devoron.values.property
{
	import devoron.data.AllIdentifiers;
	import devoron.setters.property.InstancePropertySubSetter;
	import devoron.setters.SetterBase;
	import devoron.values.oneD.OneDConstValueSubParser;
	import devoron.values.setters.ValueSubParserBase;
	import devoron.values.threeD.ThreeDConstValueSubParser;

	
	/**
	 * Парсер свойства экземпляра частицы.
	 */
	public class InstancePropertySubParser extends ValueSubParserBase
	{
		private var _positionValue:ThreeDConstValueSubParser;
		private var _rotationValue:ThreeDConstValueSubParser;
		private var _scaleValue:ThreeDConstValueSubParser;
		private var _timeOffsetValue:OneDConstValueSubParser;
		private var _playSpeedValue:OneDConstValueSubParser;
		
		/**
		 * Конструктор класса.
		 * @param	propName
		 */
		public function InstancePropertySubParser(propName:String)
		{
			super(propName, CONST_VALUE);
		}
		
		/**
		 * Процедура парсинга.
		 * Разбираются значения позиции, поворота, масштабирования,
		 * сдвига времени, скорости проигрывания.
		 * Каждое значение имеет свой парсер в зависимости от типа:
		 * один элемент или три.
		 * @return
		 */
		override protected function proceedParsing():Boolean
		{
			if (_isFirstParsing)
			{				
				if (_data.position)
				{
					_positionValue = new ThreeDConstValueSubParser(null);
					addSubParser(_positionValue);
					_positionValue.parseAsync(_data.position.data);
				}
				if (_data.rotation)
				{
					_rotationValue = new ThreeDConstValueSubParser(null);
					addSubParser(_rotationValue);
					_rotationValue.parseAsync(_data.rotation.data);
				}
				if (_data.scale)
				{
					_scaleValue = new ThreeDConstValueSubParser(null);
					addSubParser(_scaleValue);
					_scaleValue.parseAsync(_data.scale.data);
				}
				if (_data.timeOffset)
				{
					_timeOffsetValue = new OneDConstValueSubParser(null);
					addSubParser(_timeOffsetValue);
					_timeOffsetValue.parseAsync(_data.timeOffset.data);
				}
				if (_data.playSpeed)
				{
					_playSpeedValue = new OneDConstValueSubParser(null);
					addSubParser(_playSpeedValue);
					_playSpeedValue.parseAsync(_data.playSpeed.data);
				}
				
			}
			
			if (super.proceedParsing() == PARSING_DONE)
			{
				initSetter();
				return PARSING_DONE;
			}
			else
				return MORE_TO_PARSE;
		}
		
		private function initSetter():void
		{
			var positionSetter:SetterBase = _positionValue ? _positionValue.setter : null;
			var rotationSetter:SetterBase = _rotationValue ? _rotationValue.setter : null;
			var scaleSetter:SetterBase = _scaleValue ? _scaleValue.setter : null;
			var timeOffsetSetter:SetterBase = _timeOffsetValue ? _timeOffsetValue.setter : null;
			var playSpeedSetter:SetterBase = _playSpeedValue ? _playSpeedValue.setter : null;
			_setter = new InstancePropertySubSetter(_propName, positionSetter, rotationSetter, scaleSetter, timeOffsetSetter, playSpeedSetter);
		}
		
		public static function get identifier():*
		{
			return AllIdentifiers.InstancePropertySubParser;
		}
	}
}
