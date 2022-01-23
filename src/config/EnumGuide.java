package config;

public class EnumGuide {

	public enum USERSTATUS {
		ACTIVE(1),
		DEACTIVE(0);
		
		Integer value;
		private USERSTATUS(Integer value) {
			this.value = value;
		}
		
		public Integer getValue(){
			return value;
		}
	}
}
