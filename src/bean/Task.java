package bean;

public class Task {

	private Integer id;
	private String name;
	private Project project;
	private ProjectTeam projectTeam;
	private String description;
	private Boolean isCompleted;
	private String createdOn;
	private User createdBy;
	private String updatedOn;
	private User updatedBy;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Project getProject() {
		return project;
	}
	public void setProject(Project project) {
		this.project = project;
	}
	public ProjectTeam getProjectTeam() {
		return projectTeam;
	}
	public void setProjectTeam(ProjectTeam projectTeam) {
		this.projectTeam = projectTeam;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Boolean getIsCompleted() {
		return isCompleted;
	}
	public void setIsCompleted(Boolean isCompleted) {
		this.isCompleted = isCompleted;
	}
	public String getCreatedOn() {
		return createdOn;
	}
	public void setCreatedOn(String createdOn) {
		this.createdOn = createdOn;
	}
	public User getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(User createdBy) {
		this.createdBy = createdBy;
	}
	public String getUpdatedOn() {
		return updatedOn;
	}
	public void setUpdatedOn(String updatedOn) {
		this.updatedOn = updatedOn;
	}
	public User getUpdatedBy() {
		return updatedBy;
	}
	public void setUpdatedBy(User updatedBy) {
		this.updatedBy = updatedBy;
	}
	@Override
	public String toString() {
		return "Task [id=" + id + ", name=" + name + ", project=" + project + ", projectTeam=" + projectTeam
				+ ", description=" + description + ", isCompleted=" + isCompleted + ", createdOn=" + createdOn
				+ ", createdBy=" + createdBy + ", updatedOn=" + updatedOn + ", updatedBy=" + updatedBy + "]";
	}
}
