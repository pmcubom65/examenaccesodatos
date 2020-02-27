package modelo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity(name="payments")
@Table(name="payments")
public class Payments {

	@Column(name="amount_paid")
	private String amount_paid;
	
	@Column(name="description")
	private String description;
	
	@Column(name="external_reference_number")
	private String external_reference_number;
	
	@OneToOne(targetEntity=Members.class)
	@JoinColumn(name="membership_number")
	private Members members;
	
	@Column(name="payment_date")
	private String payment_date;
	
	@Id
	private String payment_id;
	
	
	public Payments() {}


	public Payments(String amount_paid, String description, String external_reference_number, Members members,
			String payment_date, String payment_id) {
		super();
		this.amount_paid = amount_paid;
		this.description = description;
		this.external_reference_number = external_reference_number;
		this.members = members;
		this.payment_date = payment_date;
		this.payment_id = payment_id;
	}


	public String getAmount_paid() {
		return amount_paid;
	}


	public void setAmount_paid(String amount_paid) {
		this.amount_paid = amount_paid;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public String getExternal_reference_number() {
		return external_reference_number;
	}


	public void setExternal_reference_number(String external_reference_number) {
		this.external_reference_number = external_reference_number;
	}


	public Members getMembers() {
		return members;
	}


	public void setMembers(Members members) {
		this.members = members;
	}


	public String getPayment_date() {
		return payment_date;
	}


	public void setPayment_date(String payment_date) {
		this.payment_date = payment_date;
	}


	public String getPayment_id() {
		return payment_id;
	}


	public void setPayment_id(String payment_id) {
		this.payment_id = payment_id;
	}


	@Override
	public String toString() {
		return "Payments [amount_paid=" + amount_paid + ", description=" + description + ", external_reference_number="
				+ external_reference_number + ", members=" + members + ", payment_date=" + payment_date
				+ ", payment_id=" + payment_id + "]";
	}


	
	
	
	
}
