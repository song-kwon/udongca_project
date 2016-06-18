package kr.co.udongca.vo;

public class Menu {

	private int menuNO;
	private int cafeNumber;
	private String menuType;
	private String menuName;
	private String menuRealImage;
	private String menuFakeImage;
	private PRBoard prBoard;
	
	
	
	public Menu() {
	}



	public Menu(int menuNO, int cafeNumber, String menuType, String menuName, String menuRealImage,
			String menuFakeImage) {
		super();
		this.menuNO = menuNO;
		this.cafeNumber = cafeNumber;
		this.menuType = menuType;
		this.menuName = menuName;
		this.menuRealImage = menuRealImage;
		this.menuFakeImage = menuFakeImage;
	}



	public Menu(int menuNO, int cafeNumber, String menuType, String menuName, String menuRealImage,
			String menuFakeImage, PRBoard prBoard) {
		super();
		this.menuNO = menuNO;
		this.cafeNumber = cafeNumber;
		this.menuType = menuType;
		this.menuName = menuName;
		this.menuRealImage = menuRealImage;
		this.menuFakeImage = menuFakeImage;
		this.prBoard = prBoard;
	}



	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + cafeNumber;
		result = prime * result + ((menuFakeImage == null) ? 0 : menuFakeImage.hashCode());
		result = prime * result + menuNO;
		result = prime * result + ((menuName == null) ? 0 : menuName.hashCode());
		result = prime * result + ((menuRealImage == null) ? 0 : menuRealImage.hashCode());
		result = prime * result + ((menuType == null) ? 0 : menuType.hashCode());
		result = prime * result + ((prBoard == null) ? 0 : prBoard.hashCode());
		return result;
	}



	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Menu other = (Menu) obj;
		if (cafeNumber != other.cafeNumber)
			return false;
		if (menuFakeImage == null) {
			if (other.menuFakeImage != null)
				return false;
		} else if (!menuFakeImage.equals(other.menuFakeImage))
			return false;
		if (menuNO != other.menuNO)
			return false;
		if (menuName == null) {
			if (other.menuName != null)
				return false;
		} else if (!menuName.equals(other.menuName))
			return false;
		if (menuRealImage == null) {
			if (other.menuRealImage != null)
				return false;
		} else if (!menuRealImage.equals(other.menuRealImage))
			return false;
		if (menuType == null) {
			if (other.menuType != null)
				return false;
		} else if (!menuType.equals(other.menuType))
			return false;
		if (prBoard == null) {
			if (other.prBoard != null)
				return false;
		} else if (!prBoard.equals(other.prBoard))
			return false;
		return true;
	}



	@Override
	public String toString() {
		return "Menu [menuNO=" + menuNO + ", cafeNumber=" + cafeNumber + ", menuType=" + menuType + ", menuName="
				+ menuName + ", menuRealImage=" + menuRealImage + ", menuFakeImage=" + menuFakeImage + ", prBoard="
				+ prBoard + "]";
	}
	
	

	
}
