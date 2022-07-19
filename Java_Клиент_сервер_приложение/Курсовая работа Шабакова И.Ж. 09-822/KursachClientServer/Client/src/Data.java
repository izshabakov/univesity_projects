
public class Data {
    private int year;
    private int month;
    private int day;
    private int wind;
    private double temp;
    private int wet;
    private double pressure;

    public Data(int year, int month, int day, int wind, double temp, int wet, double pressure) {
        this.year = year;
        this.month = month;
        this.day = day;
        this.wind = wind;
        this.temp = temp;
        this.wet = wet;
        this.pressure = pressure;
    }

    public Data(int year, int month, int day, int wind, int wet, double pressure) {
        this.year = year;
        this.month = month;
        this.day = day;
        this.wind = wind;
        this.wet = wet;
        this.pressure = pressure;
    }

    public int getYear() {
        return year;
    }

    public int getMonth() {
        return month;
    }

    public int getDay() {
        return day;
    }

    public int getWind() {
        return wind;
    }

    public double getTemp() {
        return temp;
    }

    public int getWet() {
        return wet;
    }

    public double getPressure() {
        return pressure;
    }

    @Override
    public String toString() {
        return ("Г:" + year + " М:" + month + " Д:" + day + " Ск. ветра:" + wind + " Влажность:" + wet + " Атм. давление:" + pressure);
    }
}
