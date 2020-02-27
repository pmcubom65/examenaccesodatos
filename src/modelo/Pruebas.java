package modelo;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.dialect.identity.SybaseAnywhereIdentityColumnSupport;

public class Pruebas {
	
	


	public static void main(String[] args) {

		SessionFactory sf = new Configuration().configure().buildSessionFactory();

		Session s = sf.openSession();
		s.beginTransaction();

		List<Payments> listado = s.createNativeQuery(
				"select sum(amount_paid) as amount_paid, description, external_reference_number, membership_number, payment_date, payment_id from payments group by membership_number",
				Payments.class).getResultList();
		
		
		List<Members> listadomiembros=s.createQuery("from members", Members.class).getResultList();
		
		List<Members> listadoquitar=new ArrayList<Members>();
		
		

		listado.forEach(i -> {

			System.out.println(i.getMembers().getMembership_number());
			System.out.println("Nombre: "+i.getMembers().getFull_names());
			System.out.println("Direccion: "+i.getMembers().getPysical_address());
			System.out.println("Cantidad pagada: "+i.getAmount_paid());
			listadoquitar.add(i.getMembers());
	

		});
		
//		System.out.println("quitados");
//		System.out.println(listadoquitar);
		
		listadomiembros.removeAll(listadoquitar);
		
		listadomiembros.forEach(i -> {
			System.out.println(i.getMembership_number());
			System.out.println("Nombre: "+i.getFull_names());
			System.out.println("Direccion: "+i.getPysical_address());
			System.out.println("Cantidad pagada: "+0);
			

		});
		
		
		s.getTransaction().commit();
		s.close();

	}

}
