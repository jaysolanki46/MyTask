package bean;

public class ProjectTeam {

	private Integer id;
	private Project project;
	private User teamMember;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Project getProject() {
		return project;
	}
	public void setProject(Project project) {
		this.project = project;
	}
	public User getTeamMember() {
		return teamMember;
	}
	public void setTeamMember(User teamMember) {
		this.teamMember = teamMember;
	}
	public ProjectTeam() {
	}
	public ProjectTeam(Integer id) {
		super();
		this.id = id;
	}
	@Override
	public String toString() {
		return "ProjectTeam [id=" + id + ", project=" + project + ", projectTeam=" + teamMember + "]";
	}
}
