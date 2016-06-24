package kr.co.udongca.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.udongca.dao.CodeDao;
import kr.co.udongca.vo.Code;

@Repository
public class CodeDaoImpl implements CodeDao {
    @Autowired
    private SqlSessionTemplate session;
    
    public CodeDaoImpl (SqlSessionTemplate session){
	this.session = session;
    }
    
    @Override
    public List<Code> selectCode(String code){
	return session.selectList("codeMapper.select_code", code);
    }
}
