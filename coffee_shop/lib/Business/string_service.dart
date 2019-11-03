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
}