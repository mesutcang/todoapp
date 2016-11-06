package com.todoapp.enumeration;

public enum PriorityEnum {

    LOW(0, "Low"),MID(1,"Mid"),HIGH(2,"High");

    private Integer id;

    private String name;

    PriorityEnum(Integer id, String name) {
        this.id = id;
        this.name = name;
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

}
