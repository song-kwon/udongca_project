package kr.co.udongca.dao;

import kr.co.udongca.vo.PRBoard;

public interface PrBoardDao {
	public int insertPRBoard(PRBoard prBoard);
	public int updatePRBoard(PRBoard prBoard);
	public int deletePRBoard(int cafeNo);
	public PRBoard selectPRBoardByNo (int cafeNo);
	public PRBoard selectPRBoardByCoporateNumb (String coporateNumb);
}
