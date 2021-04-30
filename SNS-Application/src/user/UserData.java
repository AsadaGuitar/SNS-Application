package user;

public class UserData {
	private static String name;
	private static String password;
	private static String email;
	private static String gender;
	private static String age;
	private static String music_type;
	private static String instrument;
	private static String favorite_musician;
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
	public void setGender(String data) {
		this.gender = data;
	}
	public void setAge(String data) {
		this.age = data;
	}
	public void setMusicType(String data) {
		this.music_type = data;
	}
	public void setInstrument(String data) {
		this.instrument = data;
	}
	public void setFavoriteMusician(String data) {
		this.favorite_musician = data;
	}
	public void setNumber(int data) {
		this.number = data;
	}

	public String getName() {
		return name;
	}
	public String getGender() {
		return gender;
	}
	public String getAge() {
		return age;
	}
	public String getMusicType() {
		return music_type;
	}
	public String getInstrument() {
		return instrument;
	}
	public String getFavoriteMusician() {
		return favorite_musician;
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
