import 'package:coffee_shop/Models/static_data.dart';

class StringService
{
    static String toDateFormatNumber(int number)
    {
        String retval = number.toString();

        if(number<10)
            retval = "0" + number.toString();

        return retval;
    }

    static int intFromDateFormat(String text) 
    {
        int res = int.tryParse(text);
        if(res == null)
        {
            res = int.tryParse(text[1]);
        }

        return res;
    }

    static String toDateFormatString(String day) 
    {
        if(day.length == 1)
        {
            return ("0" + day);
        }
        return day;
    }

    static String getPathForPic(int sugarType)
    {
        String retVal = StaticData.whiteSugarPath;
        switch(sugarType)
        {
            case 0:
                retVal = StaticData.whiteSugarPath;    
            break;
            
            case 1:
                retVal = StaticData.brownSugarPath;
            break;

            case 2:
                retVal = StaticData.sweetenerPath;
            break;

            case -1:
                retVal = "-1";
            break;
        }

        return retVal;
    }

    static int getSugarTypeFromPath(String path)
    {
        int retVal = 0;
        switch(path)
        {
            case StaticData.whiteSugarPath:
                retVal = 0;    
            break;
            
            case StaticData.brownSugarPath:
                retVal = 1;
            break;

            case StaticData.sweetenerPath:
                retVal = 2;
            break;

            case "-1":
                retVal = -1;
            break;
        }

        return retVal;
    }
}