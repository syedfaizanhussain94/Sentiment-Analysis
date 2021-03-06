package com.avricot.prediction;

import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.avricot.prediction.context.ApplicationContextHolder;

public class TwitterMain {
	public static void main(String[] args) {
		new ClassPathXmlApplicationContext(new String[] { "classpath:context/application-context.xml" });
		ApplicationContextHolder.getApplicationContext().getBean(TwitterListener.class).listen();
	}
}
