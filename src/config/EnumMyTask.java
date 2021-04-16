package config;

public class EnumMyTask {

	public enum SKYZERTECHNOLOGIES {
		ID("0"),
		COLOR("#0066cb"),
		LOGOSKYZERTECHNOLOGIES("display: none"),
		LOGOSKYZERPAYMENTS("display: block");
		
		String value;
		private SKYZERTECHNOLOGIES(String value) {
			this.value = value;
		}
		
		public String getValue(){
			return value;
		}
	}
	
	public enum SKYZERPAYMENTS {
		ID("1"),
		COLOR("#b81b44"),
		LOGOSKYZERTECHNOLOGIES("display: block"),
		LOGOSKYZERPAYMENTS("display: none");
		
		String value;
		private SKYZERPAYMENTS(String value) {
			this.value = value;
		}
		
		public String getValue(){
			return value;
		}
	}
	
	public enum SKYZERUSERTYPE {
		NORMAL(0),
		MASTER(1);
		
		int value;
		private SKYZERUSERTYPE(int value) {
			this.value = value;
		}
		
		public int getValue(){
			return value;
		}
	}
	
	public enum SKYZERTHEMETYPE {
		TECH(0),
		PAYM(1);
		
		int value;
		private SKYZERTHEMETYPE(int value) {
			this.value = value;
		}
		
		public int getValue(){
			return value;
		}
	}
	
	public enum SKYZERTASKSTATUS {
		INCOMPLETE(0),
		COMPLETED(1);
		
		int value;
		private SKYZERTASKSTATUS(int value) {
			this.value = value;
		}
		
		public int getValue(){
			return value;
		}
	}
}
