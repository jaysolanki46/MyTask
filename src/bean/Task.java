package bean;

public class Task {

	private Integer id;
	private String name;
	private Project project;
	private User team_member;
	private Integer priority;
	private String dueDate; 
	private String description;
	private Integer percentage;
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
	public String getDueDate() {
		return dueDate;
	}
	public Integer getPriority() {
		return priority;
	}
	public void setPriority(Integer priority) {
		this.priority = priority;
	}
	public void setDueDate(String dueDate) {
		this.dueDate = dueDate;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
	public User getTeam_member() {
		return team_member;
	}
	public void setTeam_member(User team_member) {
		this.team_member = team_member;
	}
	public Integer getPercentage() {
		return percentage;
	}
	public void setPercentage(Integer percentage) {
		this.percentage = percentage;
	}
	public Task() {
	}
	public Task(Integer id) {
		super();
		this.id = id;
	}
	@Override
	public String toString() {
		return "Task [id=" + id + ", name=" + name + ", project=" + project + ", team_member=" + team_member
				+ ", priority=" + priority + ", dueDate=" + dueDate + ", description=" + description + ", percentage="
				+ percentage + ", createdOn=" + createdOn + ", createdBy=" + createdBy + ", updatedOn=" + updatedOn
				+ ", updatedBy=" + updatedBy + "]";
	}
}
