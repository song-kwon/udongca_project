package kr.co.udongca.common.util;

public class TextUtil {
	public static String textToHtml(String src){
		return src.replaceAll("&", "&amp;")
				   .replaceAll("<", "&lt;")
				   .replaceAll(">", "&gt;")
				   .replaceAll(" ",  "&nbsp;")
				   .replaceAll("\n", "<br>");
	}
	
	//수정 폼 조회 시 content와 title 변환
	public static String htmlToText(String src){
		return src.replaceAll("<br>", "\n")
				   .replaceAll("&lt;", "<")
				   .replaceAll("&gt;", ">")
				   .replaceAll("&nbsp;", " ")
				   .replaceAll("&amp;", "&");
	}
}
