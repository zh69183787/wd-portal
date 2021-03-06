package com.wonders.stpt.union.action.prize;

import java.io.File;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ModelDriven;
import com.wonders.stpt.core.login.constant.LoginConstant;
import com.wonders.stpt.exam.action.AbstractParamAction;
import com.wonders.stpt.page.model.PageResultSet;
import com.wonders.stpt.union.entity.bo.UnionApplyMatch;
import com.wonders.stpt.union.entity.bo.UnionMatch;
import com.wonders.stpt.union.entity.bo.UnionPrize;
import com.wonders.stpt.union.entity.bo.prize.UnionPersonalPrize;
import com.wonders.stpt.union.entity.bo.prize.UnionProjectPrize;
import com.wonders.stpt.union.entity.vo.UnionFlowInfo;
import com.wonders.stpt.union.service.UnionApplyMatchService;
import com.wonders.stpt.union.service.UnionApprovalService;
import com.wonders.stpt.union.service.UnionPrizeService;
import com.wonders.stpt.union.service.prize.UnionProjectPrizeService;
import com.wonders.stpt.union.util.UnionProcessUtil;
import com.wonders.stpt.util.ActionWriter;
import com.wonders.stpt.util.DateUtil;
import com.wonders.stpt.util.StringUtil;

/**
 * 运营发文 
 *
 */
@SuppressWarnings("serial")
@ParentPackage("struts-default")
@Namespace(value="/unionProjectPrize")
@Controller("unionProjectPrizeAction")
@Scope("prototype")
public class UnionProjectPrizeAction extends AbstractParamAction implements ModelDriven<UnionProjectPrize> {

	private List<File> fileupload;//这里的"fileName"一定要与表单中的文件域名相同  
    private List<String> fileuploadContentType;//格式同上"fileName"+ContentType  
    private List<String> fileuploadFileName;//格式同上"fileName"+FileName  
    
    public UnionFlowInfo params = new UnionFlowInfo();
    
	private UnionProjectPrize unionProjectPrize = new UnionProjectPrize();
	
	private PageResultSet<UnionProjectPrize> pageResultSet;
	
	private ActionWriter aw = new ActionWriter(response);

	@Override
	public UnionProjectPrize getModel() {
		return unionProjectPrize;
	}

	public void setUnionProjectPrize(UnionProjectPrize unionProjectPrize) {
		this.unionProjectPrize = unionProjectPrize;
	}

	public PageResultSet<UnionProjectPrize> getPageResultSet() {
		return pageResultSet;
	}

	public void setPageResultSet(PageResultSet<UnionProjectPrize> pageResultSet) {
		this.pageResultSet = pageResultSet;
	}
	
	@Action(value="list",results={
			@Result(name="success",location="/union/themeList.jsp"),
			@Result(name="error",location="/404.jsp")
			})
	public String findPage(){
		String tloginName = (String)this.request.getSession().getAttribute(LoginConstant.STPT_SECURITY_LOGIN_NAME);
		String deptId = (String)this.request.getSession().getAttribute(LoginConstant.USER_DEPT_ID);
		

		return SUCCESS;
	}
	
	@Action(value="showAdd",results={
			@Result(name="success",location="/union/prize/projectPrizeAdd.jsp"),
			@Result(name="error",location="/404.jsp")
			})
	public String showAdd(){
		String loginName = (String)this.request.getSession().getAttribute(LoginConstant.SECURITY_LOGIN_NAME);
		String deptId = (String)this.request.getSession().getAttribute(LoginConstant.USER_DEPT_ID);
				
		return SUCCESS;
	}
	
	@Action(value="showEdit",results={
			@Result(name="success",location="/union/prize/projectPrizeAdd.jsp"),
			@Result(name="error",location="/404.jsp")
			})
	public String showEdit(){
		String loginName = (String)this.request.getSession().getAttribute(LoginConstant.SECURITY_LOGIN_NAME);
		String deptId = (String)this.request.getSession().getAttribute(LoginConstant.USER_DEPT_ID);
				
		String id = this.request.getParameter("id");
		UnionProjectPrize projectPrize = service.find(id);
		
		this.request.setAttribute("projectPrize", projectPrize);
		return SUCCESS;
	}
	
	@Action(value="showView",results={
			@Result(name="success",location="/union/prize/projectPrizeView.jsp"),
			@Result(name="error",location="/404.jsp")
			})
	public String showView(){
		String id = this.request.getParameter("id");
		UnionProjectPrize projectPrize = service.find(id);
		UnionPrize prize = this.prizeService.findById(projectPrize.getPrizeId());

		if(prize.getMatch().getStatus() == UnionMatch.PASS_STATUS){
			this.request.setAttribute("approvals", this.approvalService.findFinalApprovalInfo(projectPrize.getApplyId(), prize.getMatchId(), prize.getMatch().getThemeId()));
		}
		
		this.request.setAttribute("projectPrize", projectPrize);
		this.request.setAttribute("prize", prize);
		return SUCCESS;
	}
	
	@Action(value="save")
	public String save(){
		String loginName = (String)this.request.getSession().getAttribute(LoginConstant.SECURITY_LOGIN_NAME);
		String tloginName = (String)this.request.getSession().getAttribute(LoginConstant.STPT_SECURITY_LOGIN_NAME);
		String deptId = (String)this.request.getSession().getAttribute(LoginConstant.USER_DEPT_ID);
		String deptName = (String)this.request.getSession().getAttribute(LoginConstant.USER_DEPT_NAME);
		String userName = (String)this.request.getSession().getAttribute(LoginConstant.SECURITY_USER_NAME);
		
		String now = DateUtil.getNowTime();
		if(StringUtils.isEmpty(unionProjectPrize.getId())){
			UnionApplyMatch applyMatch = this.applyMatchService.find(unionProjectPrize.getApplyId());
			this.unionProjectPrize.setcUser(loginName);
			this.unionProjectPrize.setcTime(now);		
			this.unionProjectPrize.setcUserName(userName);
			this.unionProjectPrize.setDeptId(applyMatch.getDeptId());
			this.unionProjectPrize.setDeptName(applyMatch.getDeptName());
		}
		
		this.unionProjectPrize.setuUser(loginName);
		this.unionProjectPrize.setuTime(now);
		
		unionProjectPrize = this.service.save(unionProjectPrize);
		
		this.aw.writeAjax("1");
		return null;
	}
	
	@Action(value="doDel")
	public String doDel(){
		String id = StringUtil.getNotNullValueNumber(request.getParameter("id"));
		
		this.service.logicDelete(id);
		return null;
	}
	
	@Action(value="batchUpload")
	public String batchUpload(){
		UnionProcessUtil.prepareFlowInfo(request, params);
		
		String result = this.service.readExcel(fileupload, fileuploadFileName, params);
		
		this.aw.writeAjax(result);
		return null;
	}
	
	private UnionProjectPrizeService service;
	public UnionProjectPrizeService getService() {
		return service;
	}
	@Autowired(required=false)
	public void setService(@Qualifier("unionProjectPrizeService")UnionProjectPrizeService service) {
		this.service = service;
	}
	
	private UnionPrizeService prizeService;
	public UnionPrizeService getPrizeService() {
		return prizeService;
	}
	@Autowired(required=false)
	public void setPrizeService(@Qualifier("unionPrizeService")UnionPrizeService prizeService) {
		this.prizeService = prizeService;
	}
	
	public UnionProjectPrize getUnionProjectPrize() {
		return unionProjectPrize;
	}

	private UnionApplyMatchService applyMatchService;
	public UnionApplyMatchService getApplyMatchService() {
		return applyMatchService;
	}
	@Autowired(required=false)
	public void setApplyMatchService(@Qualifier("unionApplyMatchService")UnionApplyMatchService applyMatchService) {
		this.applyMatchService = applyMatchService;
	}
	
	private UnionApprovalService approvalService;
	public UnionApprovalService getApprovalService() {
		return approvalService;
	}
	@Autowired(required=false)
	public void setApprovalService(@Qualifier("unionApprovalService")UnionApprovalService approvalService) {
		this.approvalService = approvalService;
	}

	public List<File> getFileupload() {
		return fileupload;
	}

	public void setFileupload(List<File> fileupload) {
		this.fileupload = fileupload;
	}

	public List<String> getFileuploadContentType() {
		return fileuploadContentType;
	}

	public void setFileuploadContentType(List<String> fileuploadContentType) {
		this.fileuploadContentType = fileuploadContentType;
	}

	public List<String> getFileuploadFileName() {
		return fileuploadFileName;
	}

	public void setFileuploadFileName(List<String> fileuploadFileName) {
		this.fileuploadFileName = fileuploadFileName;
	}
	
}
