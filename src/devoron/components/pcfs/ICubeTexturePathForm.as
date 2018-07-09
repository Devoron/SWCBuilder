package devoron.components.pcfs 
{
	import devoron.components.values.cubetexture.CubeTexturePath;
	/**
	 * ICubeTexturePathForm
	 * @author Devoron
	 */
	public interface ICubeTexturePathForm 
	{
		function setRelatedCubeTexturePath(value:CubeTexturePath):void;
		function getRelatedCubeTexturePath():CubeTexturePath;
	}
	
}