package domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the orderdetails database table.
 * 
 */
@Embeddable
public class OrderdetailPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	//@Column(insertable=false, updatable=false, length=9)
	@Column(name="ordernumber")
	private Integer ordernumber;

	@Column(name="productcode")
	private String productcode;

	public OrderdetailPK() {
	}
	
	public OrderdetailPK(Integer ordernumber, String productcode) {
		this.ordernumber = ordernumber;
		this.productcode = productcode;
	}

	public Integer getOrdernumber() {
		return this.ordernumber;
	}
	public void setOrdernumber(Integer ordernumber) {
		this.ordernumber = ordernumber;
	}
	public String getProductcode() {
		return this.productcode;
	}
	public void setProductcode(String productcode) {
		this.productcode = productcode;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof OrderdetailPK)) {
			return false;
		}
		OrderdetailPK castOther = (OrderdetailPK)other;
		return 
			this.ordernumber.equals(castOther.ordernumber)
			&& this.productcode.equals(castOther.productcode);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.ordernumber.hashCode();
		hash = hash * prime + this.productcode.hashCode();
		
		return hash;
	}
}