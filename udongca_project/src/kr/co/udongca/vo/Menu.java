package kr.co.udongca.vo;

import java.io.Serializable;

public class Menu implements Serializable{

	private int menuNo;
	private int cafeNo;
	private String menuType;
	private String menuName;
	private String menuRealImage;
	private String menuFakeImage;
	private PRBoard prBoard;
	public Menu() {
	    super();
	}
	public Menu(int menuNo, int cafeNo, String menuType, String menuName, String menuRealImage,
		String menuFakeImage) {
	    super();
	    this.menuNo = menuNo;
	    this.cafeNo = cafeNo;
	    this.menuType = menuType;
	    this.menuName = menuName;
	    this.menuRealImage = menuRealImage;
	    this.menuFakeImage = menuFakeImage;
	}
	public Menu(int menuNo, int cafeNo, String menuType, String menuName, String menuRealImage,
		String menuFakeImage, PRBoard prBoard) {
	    super();
	    this.menuNo = menuNo;
	    this.cafeNo = cafeNo;
	    this.menuType = menuType;
	    this.menuName = menuName;
	    this.menuRealImage = menuRealImage;
	    this.menuFakeImage = menuFakeImage;
	    this.prBoard = prBoard;
	}
	public int getMenuNo() {
	    return menuNo;
	}
	public void setMenuNo(int menuNo) {
	    this.menuNo = menuNo;
	}
	public int getCafeNo() {
	    return cafeNo;
	}
	public void setCafeNo(int cafeNo) {
	    this.cafeNo = cafeNo;
	}
	public String getMenuType() {
	    return menuType;
	}
	public void setMenuType(String menuType) {
	    this.menuType = menuType;
	}
	public String getMenuName() {
	    return menuName;
	}
	public void setMenuName(String menuName) {
	    this.menuName = menuName;
	}
	public String getMenuRealImage() {
	    return menuRealImage;
	}
	public void setMenuRealImage(String menuRealImage) {
	    this.menuRealImage = menuRealImage;
	}
	public String getMenuFakeImage() {
	    return menuFakeImage;
	}
	public void setMenuFakeImage(String menuFakeImage) {
	    this.menuFakeImage = menuFakeImage;
	}
	public PRBoard getPrBoard() {
	    return prBoard;
	}
	public void setPrBoard(PRBoard prBoard) {
	    this.prBoard = prBoard;
	}
	@Override
	public int hashCode() {
	    final int prime = 31;
	    int result = 1;
	    result = prime * result + cafeNo;
	    result = prime * result + ((menuFakeImage == null) ? 0 : menuFakeImage.hashCode());
	    result = prime * result + ((menuName == null) ? 0 : menuName.hashCode());
	    result = prime * result + menuNo;
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
	    if (cafeNo != other.cafeNo)
		return false;
	    if (menuFakeImage == null) {
		if (other.menuFakeImage != null)
		    return false;
	    } else if (!menuFakeImage.equals(other.menuFakeImage))
		return false;
	    if (menuName == null) {
		if (other.menuName != null)
		    return false;
	    } else if (!menuName.equals(other.menuName))
		return false;
	    if (menuNo != other.menuNo)
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
	    return "Menu [menuNo=" + menuNo + ", cafeNo=" + cafeNo + ", menuType=" + menuType + ", menuName=" + menuName
		    + ", menuRealImage=" + menuRealImage + ", menuFakeImage=" + menuFakeImage + ", prBoard=" + prBoard
		    + "]";
	}
	
	
	
	
}
