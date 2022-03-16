package com.order.order.model;

import java.sql.Timestamp;
import java.time.LocalDateTime;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

@Converter(autoApply = true)
public class LocalDateAttributeConverter implements AttributeConverter<LocalDateTime, Timestamp> {


	@Override
	public Timestamp convertToDatabaseColumn(LocalDateTime localDateTime) {
		// TODO Auto-generated method stub
		return localDateTime==null?null:Timestamp.valueOf(localDateTime);
	}

	@Override
	public LocalDateTime convertToEntityAttribute(Timestamp sqlTimestamp) {
		// TODO Auto-generated method stub
		return sqlTimestamp==null?null:sqlTimestamp.toLocalDateTime();
	}

}
