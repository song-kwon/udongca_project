package kr.co.udongca.service;

import kr.co.udongca.vo.PRBoard;

public interface PrBoardService {
	public int insertPRBoard(PRBoard prBoard);
	public int updatePRBoard(PRBoard prBoard);
	public int deletePRBoard(int cafeNo);
	public PRBoard selectPRBoardByNo (int cafeNo);
	public PRBoard selectPRBoardByCoporateNumb (String coporateNumb);
}
