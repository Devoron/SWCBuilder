package devoron.components.pcfs
{
	import devoron.data.core.base.IDataContainer;
	import devoron.components.pcfs.ImagePCF;
	import devoron.components.values.cubetexture.CubeTexturePath;
	import devoron.components.values.cubetexture.CubeTexturePreviewComponent;
	import org.aswing.event.AWEvent;
	import org.aswing.ext.Form;
	import org.aswing.Icon;
	
	
	/**
	 * SingleCubeTexturePathFormRow.
	 * @author Devoron
	 */
	public class SingleCubeTexturePathFormRow extends Form implements IDataContainer, ICubeTexturePathForm
	{
		private var _relatedCubeTexturePath:CubeTexturePath;
		private var texturePathPCF:ImagePCF;
		
		public function SingleCubeTexturePathFormRow(cubeTexturePreviewComp:CubeTexturePreviewComponent)
		{
			texturePathPCF = new ImagePCF("path to texture", cubeTexturePreviewComp.onTexturePathInput);
			texturePathPCF.setPath("F:\\Desert.jpg");
			super.addLeftHoldRow(0, texturePathPCF)
			
			
			_relatedCubeTexturePath = new CubeTexturePath();
				_relatedCubeTexturePath.texturePath = "F:\\Desert.jpg";
			
			//texturePathPCF.addActionListener(collectDataFromContainer);
			texturePathPCF.addActionListener(valueChangeHandler);
			valueChangeHandler(null);
			// добавить в менеджер контейнеров данных
			//if(dataContainersManager!=null) dataContainersManager.addDataContainer(this);	
			//super.addDataChangeListener(collectDataFromContainer, texturePathPCF);
		}
		
		private function valueChangeHandler(e:AWEvent):void 
		{
			if (_relatedCubeTexturePath == null){
				_relatedCubeTexturePath = new CubeTexturePath();
				_relatedCubeTexturePath.texturePath = "F:\\Desert.jpg";
			}
			
			_relatedCubeTexturePath.texturePath = '"' +  texturePathPCF.getPath() + '"';
			
			super.dispatchEvent(new AWEvent(AWEvent.ACT));
			//gtrace("изменилось значение");
		}
		
		public function addActionListener(listener:Function):void {
			super.addEventListener(AWEvent.ACT, listener);
		}
		
		public function removeActionListener(listener:Function):void {
			super.removeEventListener(AWEvent.ACT, listener);
		}
		
		/* INTERFACE devoron.dataloader.IDataContainer */
		
		public function get dataContainerName():String 
		{
			return "SingleCubeTexturePath";
		}
		
		public function get dataContainerType():String 
		{
			return "SingleCubeTexturePath";
		}
		
		public function setDataToContainer(data:Object):void
		{
			
		}
		
		public function collectDataFromContainer(data:Object=null):Object
		{
			
			//gtrace("collect");
			return null;
		}
		
		/* INTERFACE devoron.components.ICubeTexturePathForm */
		
		public function setRelatedCubeTexturePath(value:CubeTexturePath):void 
		{
			_relatedCubeTexturePath = value;
			//texturePathPCF.setPath(value.texturePath);
			texturePathPCF.setPath("F:\\Desert.jpg");
		}
		
		public function getRelatedCubeTexturePath():CubeTexturePath 
		{
			return _relatedCubeTexturePath;
		}
		
		/* INTERFACE devoron.data.core.base.IDataContainer */
		
		public function set dataContainerName(value:String):void 
		{
			//_dataContainerName = value;
		}
		
		public function set dataContainerType(value:String):void 
		{
			//_dataContainerType = value;
		}
		
		public function get dataContainerIcon():Icon 
		{
			//return _dataContainerIcon;
			return null;
		}
		
		public function set dataContainerIcon(value:Icon):void 
		{
			//_dataContainerIcon = value;
		}
		
	
	}

}