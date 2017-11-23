using Base.Test
using Clustering
using Distances

srand(34568)

X1 = randn(2, 200) .+ [0., 5.]
X2 = randn(2, 200) .+ [-5., 0.]
X3 = randn(2, 200) .+ [5., 0.]
X = hcat(X1, X2, X3)
n = size(X,2)

D = pairwise(Euclidean(), X)

R = dbscan(D, 1.0, 10)
@test isa(R, DbscanResult)
k = length(R.seeds)
# println("k = $k")
@test k == 3
@test all(R.assignments .<= k)
@test length(R.assignments) == n
@test length(R.counts) == k
for c = 1:k
    @test countnz(R.assignments .== c) == R.counts[c]
end
@test all(R.counts .>= 180)

srand(0)
p0 = randn(3, 1000)

srand(1)
p1 = randn(3, 1000) .+ [3.0, 3.0, 0.0]

srand(2)
p2 = randn(3, 1000) .+ [-3.0, -3.0, 0.0]

points = [p0 p1 p2]


inds_1 = [1,2,3,5,8,9,10,12,15,16,17,19,20,24,25,26,33,34,35,36,37,38,39,40,43,45,46,49,50,55,56,58,59,68,69,72,74,75,76,77,78,79,82,84,85,87,88,92,95,96,97,98,99,100,102,103,105,107,110,112,115,116,117,120,121,130,137,138,144,145,147,148,149,151,153,155,157,158,159,160,163,164,165,166,167,168,169,173,174,175,176,180,183,188,189,191,193,194,197,198,200,201,202,205,206,207,209,211,216,219,220,222,224,225,228,233,235,236,241,243,247,249,250,252,253,254,258,261,262,265,268,269,271,272,273,274,279,280,284,285,288,289,291,297,302,303,304,306,307,309,310,315,317,318,321,322,326,329,331,332,336,337,338,340,341,343,348,349,354,356,358,360,361,362,364,367,370,372,375,380,382,384,396,397,398,399,403,404,408,409,411,415,417,422,423,425,427,429,432,435,437,438,446,449,450,452,453,454,458,459,460,465,466,467,468,469,470,473,474,476,478,480,484,489,490,494,497,499,506,508,512,516,517,519,521,522,525,526,529,531,532,534,537,538,540,543,544,548,551,554,557,558,560,561,562,563,568,572,573,576,577,579,586,588,598,604,605,606,607,609,615,618,622,624,626,629,632,634,635,638,639,640,641,644,648,650,652,654,657,658,660,662,663,664,665,667,671,674,676,677,678,679,682,688,690,691,692,693,695,696,697,699,700,708,710,711,714,715,716,717,719,723,724,725,726,729,735,736,737,738,740,741,744,747,748,750,751,753,757,758,759,760,761,766,767,772,776,778,779,780,781,783,784,785,788,789,791,792,793,794,795,796,798,802,804,806,807,808,809,812,816,818,820,822,823,826,828,830,831,833,835,836,837,838,847,851,854,855,856,857,858,860,862,867,868,869,870,876,877,878,880,881,882,883,888,890,892,895,897,900,901,903,905,907,909,912,913,914,915,916,918,921,924,925,926,928,930,931,932,936,938,939,940,941,943,946,950,951,954,956,958,962,963,965,968,969,970,973,974,975,976,982,985,986,988,989,990,992,994,996,998,1000,1882]
inds_2 = [66,874,999,2005,2006,2007,2008,2012,2018,2020,2025,2032,2033,2035,2037,2039,2041,2043,2046,2047,2048,2051,2052,2053,2054,2059,2064,2065,2066,2067,2068,2069,2070,2072,2074,2076,2077,2080,2081,2082,2085,2088,2089,2090,2091,2092,2094,2096,2097,2100,2102,2103,2111,2117,2118,2119,2122,2127,2128,2130,2132,2134,2137,2138,2139,2140,2145,2151,2157,2158,2159,2163,2164,2165,2166,2171,2172,2173,2176,2177,2178,2179,2182,2186,2187,2191,2194,2195,2197,2198,2199,2203,2204,2205,2206,2208,2210,2213,2214,2216,2217,2220,2221,2223,2224,2227,2228,2233,2236,2239,2241,2243,2244,2245,2246,2251,2252,2254,2255,2256,2259,2265,2267,2271,2272,2273,2276,2280,2281,2282,2283,2284,2285,2287,2288,2289,2291,2292,2293,2294,2299,2314,2317,2318,2319,2322,2323,2324,2325,2326,2327,2328,2329,2330,2332,2334,2340,2343,2344,2345,2346,2348,2349,2351,2352,2358,2360,2361,2364,2369,2370,2371,2373,2375,2376,2378,2380,2382,2384,2385,2386,2387,2388,2390,2392,2393,2394,2397,2398,2400,2403,2406,2407,2408,2409,2411,2416,2421,2423,2424,2426,2428,2429,2431,2440,2442,2445,2446,2447,2449,2453,2457,2459,2460,2461,2462,2465,2466,2472,2473,2476,2477,2479,2480,2482,2484,2488,2495,2496,2497,2500,2501,2503,2510,2511,2512,2514,2515,2517,2518,2519,2522,2524,2527,2528,2530,2535,2537,2540,2546,2547,2548,2549,2551,2555,2556,2558,2561,2564,2567,2568,2574,2578,2581,2583,2584,2587,2592,2594,2595,2597,2600,2603,2605,2607,2610,2613,2618,2621,2623,2625,2626,2627,2628,2629,2630,2631,2633,2639,2640,2641,2645,2647,2648,2649,2651,2653,2658,2664,2665,2671,2672,2673,2674,2676,2678,2679,2680,2684,2686,2688,2692,2698,2699,2701,2705,2706,2709,2710,2714,2715,2717,2719,2720,2727,2728,2729,2732,2734,2735,2736,2739,2740,2741,2742,2744,2746,2748,2752,2759,2763,2767,2769,2770,2775,2776,2778,2781,2788,2797,2799,2807,2808,2815,2819,2820,2821,2822,2823,2824,2826,2831,2835,2837,2839,2842,2843,2844,2847,2849,2852,2856,2857,2859,2861,2862,2865,2866,2867,2870,2871,2872,2874,2876,2878,2879,2880,2881,2884,2886,2889,2893,2895,2901,2902,2906,2908,2910,2913,2915,2917,2923,2926,2927,2928,2929,2930,2932,2933,2936,2938,2941,2942,2943,2945,2947,2949,2950,2951,2952,2957,2959,2961,2963,2964,2967,2968,2969,2970,2978,2980,2981,2983,2986,2988,2989,2990,2991,2994,2996,2997,2998]
inds_3 = [589,655,666,703,886,1001,1002,1004,1005,1008,1009,1010,1012,1022,1024,1029,1030,1031,1036,1037,1046,1050,1054,1055,1057,1058,1061,1062,1064,1065,1068,1069,1073,1075,1076,1077,1079,1083,1085,1088,1094,1096,1097,1103,1111,1112,1114,1117,1118,1119,1121,1122,1124,1131,1132,1135,1136,1137,1138,1141,1144,1145,1147,1149,1153,1154,1158,1160,1164,1169,1170,1171,1174,1178,1179,1180,1181,1184,1185,1186,1187,1188,1189,1190,1192,1193,1197,1199,1201,1202,1203,1204,1205,1206,1207,1208,1211,1221,1222,1223,1226,1228,1230,1231,1233,1234,1236,1239,1243,1245,1253,1255,1257,1259,1261,1262,1263,1264,1265,1266,1270,1271,1272,1273,1277,1280,1281,1283,1284,1286,1287,1288,1289,1290,1292,1293,1294,1297,1298,1299,1300,1302,1304,1305,1307,1309,1310,1313,1314,1315,1319,1322,1323,1329,1332,1333,1334,1335,1336,1342,1348,1349,1351,1354,1355,1358,1359,1361,1362,1363,1368,1369,1374,1379,1380,1381,1384,1385,1386,1394,1395,1396,1401,1403,1406,1408,1409,1410,1411,1413,1414,1415,1417,1418,1420,1421,1422,1424,1427,1428,1430,1431,1432,1436,1440,1443,1444,1445,1446,1447,1451,1454,1456,1458,1460,1461,1462,1466,1469,1470,1472,1474,1475,1476,1478,1486,1488,1490,1493,1497,1498,1501,1503,1505,1506,1507,1510,1512,1515,1517,1525,1530,1532,1535,1536,1538,1544,1545,1547,1548,1549,1551,1555,1558,1561,1565,1567,1568,1572,1573,1574,1576,1577,1578,1585,1587,1590,1593,1594,1595,1597,1600,1606,1607,1612,1614,1616,1619,1624,1627,1632,1633,1635,1637,1638,1639,1642,1643,1644,1645,1648,1651,1652,1654,1657,1659,1661,1665,1668,1673,1674,1676,1677,1678,1680,1681,1685,1689,1692,1695,1698,1699,1703,1704,1706,1707,1708,1709,1711,1712,1717,1719,1722,1723,1726,1727,1729,1730,1733,1736,1738,1739,1740,1742,1743,1750,1754,1758,1759,1760,1763,1764,1765,1767,1769,1772,1777,1778,1779,1781,1782,1789,1791,1794,1798,1799,1800,1801,1803,1804,1809,1810,1811,1812,1813,1818,1820,1821,1824,1828,1830,1831,1833,1836,1839,1841,1844,1847,1849,1852,1854,1855,1856,1860,1862,1867,1868,1869,1873,1874,1875,1877,1884,1885,1886,1891,1894,1895,1896,1897,1901,1902,1904,1907,1908,1909,1910,1911,1912,1914,1915,1918,1919,1920,1923,1924,1925,1928,1929,1931,1933,1934,1938,1939,1940,1942,1946,1948,1951,1952,1954,1955,1958,1959,1960,1961,1964,1968,1969,1971,1973,1974,1976,1977,1978,1982,1984,1985,1987,1993,1995,1996,1999,2000]

# Test normal points
clusters = dbscan(points, 0.3, min_neighbors=2, min_cluster_size=100, leafsize=20)
@test clusters[1].core_indices == inds_1
@test clusters[2].core_indices == inds_2
@test clusters[3].core_indices == inds_3

# Issue #84
clusters = dbscan(convert(Matrix{Float32}, points), 0.3f0, min_neighbors=2, min_cluster_size=100, leafsize=20)
@test clusters[1].core_indices == inds_1
@test clusters[2].core_indices == inds_2
@test clusters[3].core_indices == inds_3
