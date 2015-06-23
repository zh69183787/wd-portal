package com.wonders.stpt.deptDoc.model.bo;

// Generated 2014-10-15 14:49:13 by Hibernate Tools 3.4.0.CR1

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;

/**
 * ZDocsFile generated by hbm2java
 */
@Entity
@Table(name = "Z_DOCS_FILE")
public class ZDocsFile implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6044098238774989645L;
	private String sid;
	private String fileName;
	private String filePath;
	private String keyword;
	private String state = "1";
	private String extName;
	private String fileSize;
	private String createUser;
	private String createUserName;
	private Date createDate;
	private String updateUser;
	private String updateUserName;
	private Date updateDate;
	private String parentSid;
	private String flag;
	private String linkFlag;
	private String refId;

	@Id
	@GeneratedValue(generator="system-uuid")
	@GenericGenerator(name="system-uuid", strategy = "uuid")
	@Column(name = "SID", unique = true, nullable = false, length = 100)
	public String getSid() {
		return this.sid;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	@Column(name = "FILE_NAME", length = 200)
	public String getFileName() {
		return this.fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	@Column(name = "FILE_PATH", length = 500)
	public String getFilePath() {
		return this.filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	@Column(name = "STATE", length = 1)
	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Column(name = "EXT_NAME", length = 10)
	public String getExtName() {
		return this.extName;
	}

	public void setExtName(String extName) {
		this.extName = extName;
	}

	@Column(name = "FILE_SIZE", length = 20)
	public String getFileSize() {
		return this.fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	@Column(name = "CREATE_USER", length = 50)
	public String getCreateUser() {
		return this.createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "CREATE_DATE")
	public Date getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	@Column(name = "UPDATE_USER", length = 50)
	public String getUpdateUser() {
		return this.updateUser;
	}

	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "UPDATE_DATE")
	public Date getUpdateDate() {
		return this.updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	@Column(name = "PARENT_SID", length = 100)
	public String getParentSid() {
		return this.parentSid;
	}

	public void setParentSid(String parentSid) {
		this.parentSid = parentSid;
	}


	@Column(name = "CREATE_USER_NAME", length = 50)
	public String getCreateUserName() {
		return this.createUserName;
	}

	public void setCreateUserName(String createUserName) {
		this.createUserName = createUserName;
	}

	@Column(name = "FLAG", length = 50)
	public String getFlag() {
		return this.flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	@Column(name = "LINK_FLAG", length = 10)
	public String getLinkFlag() {
		return this.linkFlag;
	}

	public void setLinkFlag(String linkFlag) {
		this.linkFlag = linkFlag;
	}

	@Column(name = "KEYWORD", length = 500)
	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Column(name = "UPDATE_USER_NAME", length = 50)
	public String getUpdateUserName() {
		return updateUserName;
	}

	public void setUpdateUserName(String updateUserName) {
		this.updateUserName = updateUserName;
	}
	
	@Column(name = "REF_ID", length = 50)
	public String getRefId() {
		return refId;
	}

	public void setRefId(String refId) {
		this.refId = refId;
	}

}