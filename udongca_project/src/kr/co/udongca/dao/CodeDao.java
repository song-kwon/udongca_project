package kr.co.udongca.dao;

import java.util.List;

import kr.co.udongca.vo.Code;

public interface CodeDao {

    List<Code> selectCode(String code);

}