package kr.co.udongca.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.udongca.common.util.Constants;
import kr.co.udongca.dao.ReportBoardDao;
import kr.co.udongca.vo.ReportBoard;

@Repository
public class ReportBoardDaoImpl implements ReportBoardDao {
	@Autowired
	private SqlSessionTemplate session;

	public ReportBoardDaoImpl(SqlSessionTemplate session) {
		this.session = session;
	}

	public List<ReportBoard> selectList(int page, String reportType) {
		HashMap param = new HashMap();
		param.put("itemPerPage", Constants.ITEMS_PER_PAGE);
		param.put("page", page);
		param.put("reportType", reportType);
		return session.selectList("reportMapper.report_list", param);
	}

	public int countReport(String reportType) {
		return session.selectOne("reportMapper.count_report_list", reportType);
	}
	
	
	@Override
	public int countMemberReport(String memberId) {
		return session.selectOne("reportMapper.count_member_report_list",memberId);
	}
	
	@Override
	public List<ReportBoard> memberReportList(Map map) {
		return session.selectList("reportMapper.member_report_list",map);
	}
	
	@Override
	public ReportBoard memberReportDetail(int reportboardNo) {
		return session.selectOne("reportMapper.member_report_detail",reportboardNo);
	}
}
