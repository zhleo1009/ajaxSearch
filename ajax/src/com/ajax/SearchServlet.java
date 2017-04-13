package com.ajax;

import net.sf.json.JSONArray;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

/**
 * Created by Administrator on 2017-04-12.
 */
public class SearchServlet extends HttpServlet {
    static List<String> datas = new ArrayList<String>();
    //模拟数据
    static {

        datas.add("ajax");
        datas.add("ajax post");
        datas.add("becky");
        datas.add("bill");
        datas.add("james");
        datas.add("jerry");
        datas.add("hao");

    }

    @Override
    protected  void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException,IOException{
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
            System.out.print("j进来了");
            //获取客户端数据
        String keyword = request.getParameter("keyword");
        //获取关键字
        List<String> listData = getData(keyword);
        //返回json格式

//        System.out.print(JSONArray.fromObject(listData));

        response.getWriter().write(JSONArray.fromObject(listData).toString());


    }
    public List<String> getData(String keyword){
        List<String> list = new ArrayList<String>();
        for (String data:datas) {
            if(data.contains(keyword)){
                list.add(data);
            }
        }
        return  list;
    }

}
