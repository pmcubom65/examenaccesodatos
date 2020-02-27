package modelo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity(name="members")
@Table(name="members")
public class Members {
	
	
	@Id
	private String membership_number;
	
	@Column(name="contact_number")
	private String contact_number;
	
	@Column(name="date_of_birth")
	private String date_of_birth;
	
	@Column(name="email")
	private String email;
	
	@Column(name="full_names")
	private String full_names;
	
	@Column(name="gender")
	private String gender;

	
	
	@Column(name="physical_address")
	private String pysical_address;
	
	@Column(name="postal_address")
	private String postal_address;
	
	
	
	public Members(String contact_number, String date_of_birth, String email, String full_names, String gender,
			String membership_number, String pysical_address, String postal_address) {
	
		this.contact_number = contact_number;
		this.date_of_birth = date_of_birth;
		this.email = email;
		this.full_names = full_names;
		this.gender = gender;
		this.membership_number = membership_number;
		this.pysical_address = pysical_address;
		this.postal_address = postal_address;
	}

	
	public Members() {}


	public String getContact_number() {
		return contact_number;
	}


	public void setContact_number(String contact_number) {
		this.contact_number = contact_number;
	}


	public String getDate_of_birth() {
		return date_of_birth;
	}


	public void setDate_of_birth(String date_of_birth) {
		this.date_of_birth = date_of_birth;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getFull_names() {
		return full_names;
	}


	public void setFull_names(String full_names) {
		this.full_names = full_names;
	}


	public String getGender() {
		return gender;
	}


	public void setGender(String gender) {
		this.gender = gender;
	}


	public String getMembership_number() {
		return membership_number;
	}


	public void setMembership_number(String membership_number) {
		this.membership_number = membership_number;
	}


	public String getPysical_address() {
		return pysical_address;
	}


	public void setPysical_address(String pysical_address) {
		this.pysical_address = pysical_address;
	}


	public String getPostal_address() {
		return postal_address;
	}


	public void setPostal_address(String postal_address) {
		this.postal_address = postal_address;
	}


	@Override
	public String toString() {
		return "Members [contact_number=" + contact_number + ", date_of_birth=" + date_of_birth + ", email=" + email
				+ ", full_names=" + full_names + ", gender=" + gender + ", membership_number=" + membership_number
				+ ", pysical_address=" + pysical_address + ", postal_address=" + postal_address + "]";
	}
	
	
	
	
}
