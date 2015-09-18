/*------------------------------------------------------------------------- 
 * 版权所有：
 * 作者：姜晗
 * 联系方式：tonghuajianghan@gmail.com 
 * 创建时间：2015-9-18 下午2:13:27 
 * 版本号：v1.0 
 * 本类主要用途描述： 
 * 
-------------------------------------------------------------------------*/
package springtest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestExecutionListeners;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.support.DependencyInjectionTestExecutionListener;
import org.springframework.test.context.support.DirtiesContextTestExecutionListener;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.test.context.transaction.TransactionalTestExecutionListener;
import org.springframework.transaction.annotation.Transactional;

import com.jh.beans.Person;
import com.jh.service.PersonService;

@ContextConfiguration(locations = { "classpath:spring-context.xml",
		"classpath:spring-servlet.xml" })
@RunWith(SpringJUnit4ClassRunner.class)
@Transactional
// 加载事务管理类，可以省略
@TransactionConfiguration(transactionManager = "txManager", defaultRollback = true)
// 测试执行的类
@TestExecutionListeners(listeners = {
		DependencyInjectionTestExecutionListener.class,
		DirtiesContextTestExecutionListener.class,
		TransactionalTestExecutionListener.class })
public class PersonServiceTest {

	@Autowired
	private PersonService personService;

	// @Test
	public void testSavePerson() {
		// save
		Person person = new Person();
		person.setName("穆六");
		personService.savePerson(person);
	}

	// @Test
	public void testTestEm() {
		Person person = new Person();
		person.setId(9);
		person.setName("穆5");
		Person personParam = personService.testEm(person);
		System.out.println("------------------------");
		System.out.println(personParam.getName());
	}

	@Test
	public void testTestJunit() {
		Person person = new Person();
		person.setName("穆12六");
		personService.savePerson(person);
	}

	// @Test
	public void testSelectPersonJPQL() {

	}

	// @Test
	public void testSelectPersonWithPage() {

	}

}