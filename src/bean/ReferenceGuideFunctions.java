package bean;

public class ReferenceGuideFunctions {

	private Integer id;
	private String name;
	private String short_solution;
	private String long_solutions;
	private String note;
	private Boolean is_telium;
	private Boolean is_tetra;
	private Boolean is_function;
	private Boolean is_menu;
	private User createdBy;
	private String createdOn;
	private String updatedOn;
	private User updatedBy;
	
	public ReferenceGuideFunctions() {
	}
	
	public ReferenceGuideFunctions(Integer id, String name, String short_solution, String long_solutions, String note,
			Boolean is_telium, Boolean is_tetra, Boolean is_function, Boolean is_menu, User createdBy, String createdOn,
			String updatedOn, User updatedBy) {
		super();
		this.id = id;
		this.name = name;
		this.short_solution = short_solution;
		this.long_solutions = long_solutions;
		this.note = note;
		this.is_telium = is_telium;
		this.is_tetra = is_tetra;
		this.is_function = is_function;
		this.is_menu = is_menu;
		this.createdBy = createdBy;
		this.createdOn = createdOn;
		this.updatedOn = updatedOn;
		this.updatedBy = updatedBy;
	}

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

	public String getShort_solution() {
		return short_solution;
	}

	public void setShort_solution(String short_solution) {
		this.short_solution = short_solution;
	}

	public String getLong_solutions() {
		return long_solutions;
	}

	public void setLong_solutions(String long_solutions) {
		this.long_solutions = long_solutions;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Boolean getIs_telium() {
		return is_telium;
	}

	public void setIs_telium(Boolean is_telium) {
		this.is_telium = is_telium;
	}

	public Boolean getIs_tetra() {
		return is_tetra;
	}

	public void setIs_tetra(Boolean is_tetra) {
		this.is_tetra = is_tetra;
	}

	public Boolean getIs_function() {
		return is_function;
	}

	public void setIs_function(Boolean is_function) {
		this.is_function = is_function;
	}

	public Boolean getIs_menu() {
		return is_menu;
	}

	public void setIs_menu(Boolean is_menu) {
		this.is_menu = is_menu;
	}

	public User getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(User createdBy) {
		this.createdBy = createdBy;
	}

	public String getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(String createdOn) {
		this.createdOn = createdOn;
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
		return "ReferenceGuideFunctions [id=" + id + ", name=" + name + ", short_solution=" + short_solution
				+ ", long_solutions=" + long_solutions + ", note=" + note + ", is_telium=" + is_telium + ", is_tetra="
				+ is_tetra + ", is_function=" + is_function + ", is_menu=" + is_menu + ", createdBy=" + createdBy
				+ ", createdOn=" + createdOn + ", updatedOn=" + updatedOn + ", updatedBy=" + updatedBy + "]";
	}
	
}
