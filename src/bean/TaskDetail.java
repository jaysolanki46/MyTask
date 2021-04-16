package bean;

public class TaskDetail {

	private Integer id;
	private Task task;
	private String taskDetailDate;
	private String hours;
	private String description;
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
	public Task getTask() {
		return task;
	}
	public void setTask(Task task) {
		this.task = task;
	}
	public String getTaskDetailDate() {
		return taskDetailDate;
	}
	public void setTaskDetailDate(String taskDetailDate) {
		this.taskDetailDate = taskDetailDate;
	}
	public String getHours() {
		return hours;
	}
	public void setHours(String hours) {
		this.hours = hours;
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
	@Override
	public String toString() {
		return "TaskDetail [id=" + id + ", task=" + task + ", taskDetailDate=" + taskDetailDate + ", hours=" + hours
				+ ", description=" + description + ", createdOn=" + createdOn + ", createdBy=" + createdBy
				+ ", updatedOn=" + updatedOn + ", updatedBy=" + updatedBy + "]";
	}
}
