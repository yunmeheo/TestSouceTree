package com.my.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.my.vo.Customer;

public class MyValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		
		return Customer.class.isAssignableFrom(clazz);
	}
	
	
	@Override
	public void validate(Object target, Errors errors) {
				
		String field = "id";
		String errorCode = "required";
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, field, errorCode);
		
	}
	
}



/*Customer c = (Customer)target;
if(c.getId()==null || c.getId().trim().equals("")){
	errors.rejectValue("id","required");
}*/