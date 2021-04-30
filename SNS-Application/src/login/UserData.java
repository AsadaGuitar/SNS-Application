package login;

public class UserData {
	private static String name;
	private static String password;
	private static String email;
	private static int number;

	public void setName(String data) {
		this.name = data;
	}
	public void setPassword(String data) {
		this.password = data;
	}
	public void setEmail(String data) {
		this.email = data;
	}
	public void setNumber(int data) {
		this.number = data;
	}
	public String getName() {
		return name;
	}
	public String getPassword() {
		return password;
	}
	public String getEmail() {
		return email;
	}
	public int getNumber() {
		return number;
	}
}
