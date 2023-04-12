#include <boost/date_time/gregorian/gregorian.hpp>
#include <boost/date_time/c_local_time_adjustor.hpp>
#include <boost/date_time/local_time/local_time.hpp>
#include <boost/date_time/posix_time/posix_time.hpp>

// boost::posix_time::ptime と エポックからの秒数(int64_t) との変換
int64_t PosixTimeToSeconds(boost::posix_time::ptime t)
{
    boost::posix_time::ptime epoch(boost::gregorian::date(1970, 1, 1));
    int64_t result = (t - epoch).total_seconds();
    return result;
}
boost::posix_time::ptime SecondsToPosixTime(int64_t n)
{
    boost::posix_time::ptime result(boost::gregorian::date(1970, 1, 1),
                                    boost::posix_time::seconds(n));
    return result;
}

// boost::posix_time::ptime と エポックからのミリ秒数(int64_t) との変換
int64_t PosixTimeToMilliSeconds(boost::posix_time::ptime t)
{
    boost::posix_time::ptime epoch(boost::gregorian::date(1970, 1, 1));
    int64_t result = (t - epoch).total_milliseconds();
    return result;
}
boost::posix_time::ptime MilliSecondsToPosixTime(int64_t n)
{
    boost::posix_time::ptime result(boost::gregorian::date(1970, 1, 1),
                                    boost::posix_time::milliseconds(n));
    return result;
}

// boost::posix_time::ptime のローカルタイム/UTCタイムの変換
boost::posix_time::ptime LocalToUtc(boost::posix_time::ptime t)
{
    boost::posix_time::ptime utc =
        boost::posix_time::second_clock::universal_time();
    boost::posix_time::ptime local = boost::date_time::c_local_adjustor<
        boost::posix_time::ptime>::utc_to_local(utc);
    boost::posix_time::time_duration diff = (utc - local);
    return t + diff;
}
boost::posix_time::ptime UtcToLocal(boost::posix_time::ptime t)
{
    boost::posix_time::ptime utc =
        boost::posix_time::second_clock::universal_time();
    boost::posix_time::ptime local = boost::date_time::c_local_adjustor<
        boost::posix_time::ptime>::utc_to_local(utc);
    boost::posix_time::time_duration diff = (local - utc);
    return t + diff;
}

// boost::posix_time::ptime を 2023-04-10T07:01:45.015000　のような形式に変換
std::string PtimeToString(const boost::posix_time::ptime &t)
{
    return boost::posix_time::to_iso_extended_string(t);
#if 0
    std::stringstream ss;
    ss.imbue(
        std::locale(std::locale::classic(),
                    new boost::posix_time::time_facet("%Y-%m-%dT%H:%M:%S.%f")));
    ss << t;
    return ss.str();
#endif
}
// boost::posix_time::ptime を 2023-04-10T07:01:45.015000　のような形式から変換
boost::posix_time::ptime StringToPtime(const std::string &s)
{
    return boost::posix_time::from_iso_extended_string(s);
}

int main(int argc, char *argv[])
{
    boost::gregorian::date d(2002, 2, 1);  // an arbitrary date
    boost::posix_time::ptime t1(
        d, boost::posix_time::hours(5) +
            boost::posix_time::millisec(100));  // date + time of day offset
    std::cout << "t1: " << t1 << std::endl;
    boost::posix_time::ptime myptime(
        boost::gregorian::date(1968, 12, 14),
        boost::posix_time::hours(1) + boost::posix_time::minutes(2) +
            boost::posix_time::seconds(3) + boost::posix_time::milliseconds(4));
    std::cout << "myptime: " << myptime << std::endl;
    auto etime = PosixTimeToSeconds(myptime);
    std::cout << etime << std::endl;
    std::cout << sizeof(boost::posix_time::time_duration::sec_type) << std::endl;
    std::cout << SecondsToPosixTime(etime) << std::endl;
    etime = PosixTimeToMilliSeconds(myptime);
    std::cout << etime << std::endl;
    std::cout << MilliSecondsToPosixTime(etime) << std::endl;
    boost::posix_time::ptime t2 =
        t1 - boost::posix_time::minutes(4) + boost::posix_time::seconds(2);
    boost::posix_time::ptime now =
        boost::posix_time::second_clock::local_time();  // use the clock
    boost::gregorian::date today =
        now.date();  // Get the date part out of the time
    boost::gregorian::date tomorrow =
        today + boost::gregorian::date_duration(1);
    boost::posix_time::ptime tomorrow_start(tomorrow);  // midnight

    // input streaming
    std::stringstream ss("2004-Jan-1 05:21:33.20");
    ss >> t2;

    // starting at current time iterator adds by one hour
    boost::posix_time::time_iterator titr(now, boost::posix_time::hours(1));
    for (; titr < tomorrow_start; ++titr)
    {
        std::cout << (*titr) << std::endl;
    }

    boost::posix_time::ptime now2 = boost::posix_time::second_clock::local_time();
    now2 += boost::posix_time::millisec(15);
    std::cout << "Current date and time: " << PtimeToString(now2) <<  std::endl;

    boost::posix_time::ptime utc = LocalToUtc(now2);
    std::cout << "Current UTC time: " << PtimeToString(utc) << "Z" << std::endl;

    boost::posix_time::ptime pt;
    pt = boost::posix_time::from_iso_extended_string(PtimeToString(utc)+"Z");
    std::cout << "Converted string to ptime: " << PtimeToString(pt) << "Z" << std::endl;

    boost::posix_time::ptime local = UtcToLocal(utc);
    std::cout << boost::posix_time::to_iso_extended_string(local) << std::endl;

    return 0;
}
