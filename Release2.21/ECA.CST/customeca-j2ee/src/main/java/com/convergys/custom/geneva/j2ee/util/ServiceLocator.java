package com.convergys.custom.geneva.j2ee.util;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;
/**
 * 
 * @author tkon2950
 *
 */
public class ServiceLocator 
{
	private static ServiceLocator me;
	   private BeanFactory beanFactory;
	   private ServiceLocator()throws Exception
	   {

	      try{
	         this.beanFactory = new ClassPathXmlApplicationContext( new String[] {"ECA-ejb-service-spring.xml", "pf-services-spring.xml", "com/convergys/platform/beanResourcesContext.xml"});
	      }
	      catch(Exception e)
	      {
			// e.printStackTrace();
	         throw new Exception("Unable to load the configuration file\n" + e.getMessage());
	      }

	   }

	   public static ServiceLocator getInstance()throws Exception
	   {
	      if ( me == null)
	      {
	         me = new ServiceLocator();
	      }
	      return me;
	   }

	   public Object getBean(String beanId)throws Exception
	   {
	      if (beanId == null)
	      {
	         throw new Exception("BeanId cannot be null");
	      }
	      return beanFactory.getBean(beanId);
	   }


}
