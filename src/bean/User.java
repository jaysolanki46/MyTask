package bean;

public class User {

	private Integer id;
	private String name;
	private String email;
	private String pass;
	private String theme;
	
	public User() {	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getTheme() {
		return theme;
	}
	public void setTheme(String theme) {
		this.theme = theme;
	}
	public User(Integer id) {
		this.id = id;
	}
	public User(String name, String pass) {
		this.name = name;
		this.pass = pass;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", email=" + email + ", pass=" + pass + ", theme=" + theme + "]";
	}
}
