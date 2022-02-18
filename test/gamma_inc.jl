@testset "incomplete gamma ratios" begin
#Computed using Wolframalpha gamma(a,x)/gamma(a) ~ gamma_q(a,x,0) function.
    @test gamma_inc(10, 10)[2] ≈ 0.45792971447185221
    @test gamma_inc(1, 1)[2] ≈ 0.3678794411714423216
    @test gamma_inc(0.5, 0.5)[2] ≈ 0.31731050786291410
    @test gamma_inc(BigFloat(30.5), BigFloat(30.5))[2] ≈ parse(BigFloat,"0.47591691193354987004") rtol=eps()
    @test gamma_inc(5.5, 0.5)[2] ≈ 0.9999496100513121669
    @test gamma_inc(0.5, 7.4)[2] ≈ 0.0001195355018130302
    @test gamma_inc(0.5, 0.22)[2] ≈ 0.507122455359825146
    @test gamma_inc(0.5, 0.8)[2] ≈ 0.20590321073206830887
    @test gamma_inc(11.5, 0.5)[2] ≈ 0.999999999998406112
    @test gamma_inc(0.19, 0.99)[2] ≈ 0.050147247342905857
    @test gamma_inc(0.9999, 0.9999)[2] ≈ 0.3678730556923103
    @test gamma_inc(24, 23.9999999999)[2] ≈ 0.472849720555859138
    @test gamma_inc(0.5, 0.55)[2] ≈ 0.29426610430496289
    @test gamma_inc(Float32(0.5), Float32(0.55))[2] ≈ Float32(gamma_inc(0.5,0.55)[2])
    @test gamma_inc(Float16(0.5), Float16(0.55))[2] ≈ Float16(gamma_inc(0.5,0.55)[2])
    @test gamma_inc(30, 29.99999)[2] ≈ 0.475717712451705704
    @test gamma_inc(30, 29.9)[2] ≈ 0.482992166284958565
    @test gamma_inc(10, 0.0001)[2] ≈ 1.0000
    @test gamma_inc(0.0001, 0.0001)[2] ≈ 0.000862958131006599
    @test gamma_inc(0.0001, 10.5)[1] ≈ 0.999999999758896146
    @test gamma_inc(1, 1)[1] ≈ 0.63212055882855768
    @test gamma_inc(13, 15.1)[2] ≈ 0.25940814264863701
    @test gamma_inc(0.6, 1.3)[2] ≈ 0.136458554006505355
    @test gamma_inc(100, 80)[2] ≈ 0.9828916869648668
    @test gamma_inc(100, 80, 1)[2] ≈ 0.9828916869
    @test Float16(gamma_inc(100, 80, 2)[2]) ≈ Float16(.983)
    @test gamma_inc(13.5, 15.1)[2] ≈ 0.305242642543419087
    @test gamma_inc(11, 9)[1] ≈ 0.2940116796594881834
    @test gamma_inc(8, 32)[1] ≈ 0.99999989060651042057
    @test gamma_inc(15, 16)[2] ≈ 0.3675273597655649298
    @test gamma_inc(15.5, 16)[2] ≈ 0.4167440299455427811
    @test gamma_inc(0.9, 0.8)[1] ≈ 0.59832030278768172
    @test gamma_inc(1.7, 2.5)[1] ≈ 0.78446115627678957
    @test gamma_inc(11.1, 0.001)[2] ≈ 1.0000
    @test gamma_inc(1e7, 1e7 + 1)[1] ≈ 0.5001682088254367
    @test gamma_inc(1e7, 1e7 + 1)[2] ≈ 0.4998317911745633
    @test gamma_inc(29.0, 0.3)[1] ≈ 5.80834761514062e-47
    @test gamma_inc(29.0, 1000.0)[2] == 0.0
    @test gamma_inc(1e300, 1e-100)[1] == 0.0
    @test gamma_inc(7.098843361278083e33, 7.098843361278083e33*2)[2] == 0.0
    @test gamma_inc(7.098843361278083e33, 7.098843361278083e33/2)[1] == 0.0
    @test gamma_inc(1.1, 1e3)[2] == 0.0
    @test gamma_inc(24.0, 1e-323)[1] == 0.0
    @test gamma_inc(6311.0, 6311.0*0.59999)[1] < 1e-300
    @test gamma_inc(0.5, Inf) == (1.0, 0.0)
    @test all(isnan, gamma_inc(NaN, 1.0))
    @test all(isnan, gamma_inc(1.0, NaN))
    @test all(isnan, gamma_inc(NaN, Inf))
    @test_throws DomainError gamma_inc(-1, 2, 2)
    @test_throws DomainError gamma_inc(0, 0, 1)
    @test_throws DomainError gamma_inc(7.098843361278083e33, 7.09884336127808e33)
    @test_throws DomainError gamma_inc(6.693195169205051e28, 6.693195169205049e28)
    @test_throws DomainError gamma_inc(NaN, -1.0)
    @test_throws DomainError gamma_inc(-1.0, NaN)
    @test_throws DomainError gamma_inc(1.0, -Inf)
end

@testset "inverse of incomplete gamma ratios" begin
    #Compared with Scipy.special.gammaincinv
    @test gamma_inc_inv(1.0,0.5,0.5) ≈ 0.69314718055994529

    @testset "a=0.4" begin
        @testset "p=$p, x=$x" for (p, x) in zip(
            0.0:0.01:1.0,
            [0.0, 7.4153939596077105e-06, 4.1948837553001128e-05, 0.00011560348487144592, 0.00023733157806706144, 0.00041465371557152853, 0.00065420366900931063, 0.00096200074513191707, 0.0013436111982025845, 0.0018042543050560357, 0.0023488772409990069, 0.0029822108340951982, 0.0037088128669865747, 0.0045331028890989175, 0.0054593910326394268, 0.0064919024756292113, 0.0076347986776777021, 0.0088921961857776899, 0.010268183591667559, 0.011766837076460529, 0.013392234877244308, 0.015148470939019535, 0.01703966796416153, 0.019069990034434534, 0.021243654953428382, 0.02356494643740838, 0.026038226268114743, 0.028667946510727123, 0.031458661893117974, 0.034415042438025324, 0.037541886437423046, 0.040844133857854445, 0.044326880266606375, 0.047995391371211706, 0.051855118268798489, 0.055911713507252728, 0.060171048067033703, 0.064639229380863375, 0.069322620518498704, 0.074227860675536064, 0.079361887118881563, 0.084731958757381876, 0.090345681524433508, 0.09621103578051432, 0.10233640596793599, 0.10873061277817557, 0.11540294812451861, 0.12236321325012786, 0.12962176034488948, 0.13718953809449788, 0.14507814164343533, 0.15329986752124386, 0.16186777416055501, 0.17079574872787454, 0.18009858109673355, 0.18979204592069479, 0.19989299391476917, 0.21041945363284603, 0.22139074524173796, 0.23282760804678732, 0.24475234382888267, 0.25718897841979127, 0.27016344438650586, 0.28370378823436093, 0.29784040619656998, 0.3126063134848735, 0.32803745287127684, 0.34417304970517859, 0.36105602201014886, 0.37873345623790661, 0.39725716170037845, 0.41668431981048032, 0.43707824825000413, 0.45850930533751827, 0.4810559665889298, 0.50480611430358513, 0.52985859275268155, 0.55632509731250579, 0.58433248729003373, 0.61402564160686812, 0.64557101747749401, 0.67916113010215806, 0.71502025447176809, 0.75341177168885431, 0.79464776273185678, 0.83910172694543061, 0.8872257293787823, 0.93957396283390326, 0.99683583211997739, 1.0598835767754553, 1.1298428254726491, 1.2082007260001051, 1.296978498210863, 1.3990206562238474, 1.5185103158285946, 1.6619620177540984, 1.8403447442261882, 2.0743414883146705, 2.4107139457641296, 3.0000967446589719, Inf,])

            @test gamma_inc_inv(0.4, p, 1.0 - p) ≈ x # scipy.special.gammaincinv(0.4, p)
        end
        @testset "p=$p" for (p, x) in zip(
            exp10.(-100:1:-1),
            [7.415354682563877e-251, 2.3449410454897727e-248, 7.415354682564366e-246, 2.3449410454896607e-243, 7.415354682564292e-241, 2.3449410454897935e-238, 7.415354682563938e-236, 2.34494104548977e-233, 7.415354682564147e-231, 2.344941045489658e-228, 7.415354682564636e-226, 2.344941045489724e-223, 7.41535468256386e-221, 2.3449410454898783e-218, 7.415354682564349e-216, 2.3449410454897664e-213, 7.415354682564417e-211, 2.344941045489788e-208, 7.415354682564063e-206, 2.3449410454898092e-203, 7.41535468256413e-201, 2.344941045489697e-198, 7.415354682564197e-196, 2.344941045489718e-193, 7.415354682563843e-191, 2.344941045489873e-188, 7.415354682564331e-186, 2.344941045489761e-183, 7.415354682564399e-181, 2.3449410454897823e-178, 7.415354682564045e-176, 2.3449410454898037e-173, 7.415354682564112e-171, 2.3449410454896913e-168, 7.415354682564179e-166, 2.344941045489713e-163, 7.415354682563825e-161, 2.3449410454898675e-158, 7.415354682564313e-156, 2.3449410454897555e-153, 7.415354682564381e-151, 2.3449410454897767e-148, 7.415354682564449e-146, 2.344941045489798e-143, 7.415354682564094e-141, 2.344941045489658e-138, 7.415354682564162e-136, 2.3449410454897074e-133, 7.415354682563982e-131, 2.3449410454897003e-128, 7.415354682563786e-126, 2.34494104548975e-123, 7.415354682564117e-121, 2.3449410454896933e-118, 7.41535468256392e-116, 2.3449410454897142e-113, 7.41535468256383e-111, 2.344941045489669e-108, 7.415354682563897e-106, 2.3449410454896235e-103, 7.415354682564017e-101, 2.3449410454897116e-98, 7.415354682563821e-96, 2.3449410454896665e-93, 7.415354682563888e-91, 2.3449410454896207e-88, 7.41535468256401e-86, 2.3449410454897088e-83, 7.415354682563812e-81, 2.344941045489663e-78, 7.415354682563879e-76, 2.3449410454896845e-73, 7.415354682564194e-71, 2.3449410454897173e-68, 7.41535468256405e-66, 2.3449410454897024e-63, 7.415354682564055e-61, 2.3449410454896934e-58, 7.415354682563975e-56, 2.344941045489715e-53, 7.415354682563936e-51, 2.3449410454897025e-48, 7.415354682564003e-46, 2.3449410454896907e-43, 7.415354682563965e-41, 2.3449410454897118e-38, 7.415354682563919e-36, 2.344941045489705e-33, 7.415354682564012e-31, 2.344941045489693e-28, 7.415354682563972e-26, 2.3449410454897143e-23, 7.415354682563921e-21, 2.3449410454897024e-18, 7.41535468256397e-16, 2.344941045490093e-13, 7.415354682956721e-11, 2.3449410847664773e-8, 7.415393959607736e-6, 0.0023488772409990056])

            @test gamma_inc_inv(0.4, p, 1.0 - p) ≈ x # test values from Wolfram Engine
        end
        @testset "q=$q" for (q, x) in zip(
            exp10.(-100:1:-1),
            [226.20632559340964, 223.90983604997555, 221.61340890265456, 219.31704544035938, 217.0207469923212, 214.72451492978786, 212.4283506678122, 210.13225566713683, 207.83623143618115, 205.54027953313744, 203.24440156818332, 200.948599205819, 198.6528741673364, 196.35722823343076, 194.06166324696395, 191.7661811158899, 189.47078381635438, 187.17547339598144, 184.8802519773597, 182.58512176174432, 180.29008503298965, 177.99514416173082, 175.70030160983316, 173.40555993513033, 171.1109217964737, 168.8163899591182, 166.5219673004719, 164.22765681623838, 161.93346162698572, 159.6393849851774, 157.34543028270463, 155.05160105896397, 152.75790100952798, 150.46433399546194, 148.1709040533453, 145.877615406063, 143.58447247443803, 141.29147988978593, 138.9986425074798, 136.70596542162457, 134.4134539809525, 132.12111380606208, 129.8289508081399, 127.53697120932121, 125.24518156486371, 122.9535887873316, 120.6622001730134, 118.3710234308247, 116.08006671398151, 113.78933865476961, 111.49884840277915, 109.20860566702754, 106.91862076245451, 104.62890466134462, 102.33946905031745, 100.05032639362369, 97.76149000360293, 95.47297411929691, 93.18479399437692, 90.89696599574032, 88.6095077143667, 86.32243809030784, 84.03577755402803, 81.74954818672738, 79.46377390278907, 77.17848065811307, 74.89369668886805, 72.60945278614447, 70.32578261317965, 68.04272307331645, 65.760314738741, 63.478602352441555, 61.19763541890368, 58.91746890302822, 56.63816406193415, 54.35978944111495, 52.08242207545707, 49.80614894775916, 47.53106877385277, 45.25729420603855, 42.98495457802489, 40.71419935899122, 38.44520254811867, 36.17816833387934, 33.91333848053161, 31.651002113928772, 29.391508904360446, 27.13528716308104, 24.882869220681588, 22.6349278996998, 20.392330438271944, 18.156220906070278, 15.92815123591499, 13.710299723403262, 11.505857479008105, 9.319764935767443, 7.160260326340817, 5.042608588459961, 3.000096744658973, 1.1298428254726531])

            @test gamma_inc_inv(0.4, 1.0 - q, q) ≈ x # test values from Wolfram Engine
        end
    end

    @testset "a=0.8" begin
        @testset "p=$p, x=$x" for (p, x) in zip(
            0.0:0.01:1.0,
            [0.0, 0.0028980766274747166, 0.006908184939374363, 0.01149696382036067, 0.016518276652159908, 0.02189753286142773, 0.027589145508248085, 0.03356249352199024, 0.03979579246097344, 0.046272957709150415, 0.052981821800176826, 0.05991304249771414, 0.06705939521991744, 0.07441529398164964, 0.08197645553388541, 0.08973965716025696, 0.09770255795612678, 0.10586356446493835, 0.11422172813580914, 0.12277666614622669, 0.1315284997431042, 0.14047780597228823, 0.14962557982476085, 0.15897320462672093, 0.16852242906309764, 0.17827534962728914, 0.18823439758407795, 0.19840232975077693, 0.2087822225659563, 0.21937746904082012, 0.23019177828605702, 0.24122917738430874, 0.2524940154406757, 0.2639909696948641, 0.27572505362160177, 0.2877016269830214, 0.29992640782953106, 0.31240548647561406, 0.325145341505105, 0.33815285788768823, 0.35143534731545956, 0.36500057089608295, 0.3788567643680646, 0.3930126660346167, 0.40747754764618266, 0.4222612484987209, 0.4373742130560526, 0.4528275324509786, 0.4686329902724166, 0.48480311310582785, 0.5013512263630729, 0.5182915160173085, 0.5356390969506658, 0.5534100887296879, 0.5716216997488716, 0.5902923208297984, 0.6094416295366399, 0.6290907066738872, 0.649262166675578, 0.6699803038855925, 0.6912712570761026, 0.7131631949691678, 0.7356865260311793, 0.7588741364223205, 0.7827616607300203, 0.807387791030685, 0.832794630951811, 0.8590281028041281, 0.8861384175955134, 0.9141806199237333, 0.943215222504511, 0.9733089486005939, 1.0045356051136263, 1.0369771149071734, 1.0707247444923012, 1.1058805731481947, 1.1425592627436494, 1.1808902052215764, 1.2210201487102676, 1.2631164361809093, 1.307371036420099, 1.354005611796903, 1.4032779600790313, 1.4554903028704096, 1.5110000943860755, 1.5702343296128558, 1.633708805354231, 1.7020545444724036, 1.7760548371325608, 1.8566984660391717, 1.9452584157780999, 2.043412265612975, 2.153433912595464, 2.278514210551947, 2.4233308771016073, 2.595143613479916, 2.8061289679463384, 3.079145167578199, 3.4655956756034487, 4.12987911692835, Inf])

            @test gamma_inc_inv(0.8, p, 1.0 - p) ≈ x # scipy.special.gammaincinv(0.4, p)
        end
        @testset "p=$p" for (p, x) in zip(
            exp10.(-100:1:-1),
            [9.149783811511401e-126, 1.6270872158318525e-124, 2.8934156942512235e-123, 5.14530155377051e-122, 9.149783811511527e-121, 1.6270872158318365e-119, 2.8934156942512495e-118, 5.1453015537705576e-117, 9.149783811511568e-116, 1.6270872158317895e-114, 2.8934156942512756e-113, 5.1453015537705805e-112, 9.149783811511173e-111, 1.6270872158318043e-109, 2.89341569425122e-108, 5.145301553770358e-107, 9.149783811511515e-106, 1.627087215831819e-104, 2.893415694251246e-103, 5.145301553770551e-102, 9.14978381151134e-101, 1.6270872158317876e-99, 2.8934156942512726e-98, 5.145301553770451e-97, 9.149783811511162e-96, 1.6270872158318025e-94, 2.8934156942512166e-93, 5.145301553770352e-92, 9.149783811511506e-91, 1.627087215831817e-89, 2.893415694251243e-88, 5.145301553770545e-87, 9.149783811511328e-86, 1.6270872158317858e-84, 2.893415694251269e-83, 5.145301553770446e-82, 9.149783811511152e-81, 1.6270872158318004e-79, 2.893415694251213e-78, 5.145301553770346e-77, 9.149783811511494e-76, 1.6270872158318152e-74, 2.8934156942513214e-73, 5.145301553770539e-72, 9.149783811511317e-71, 1.62708721583183e-69, 2.8934156942513137e-68, 5.145301553770525e-67, 9.149783811511401e-66, 1.627087215831845e-64, 2.893415694251292e-63, 5.145301553770572e-62, 9.149783811511483e-61, 1.6270872158318134e-59, 2.893415694251318e-58, 5.145301553770581e-57, 9.149783811511437e-56, 1.6270872158318282e-54, 2.893415694251303e-53, 5.145301553770507e-52, 9.14978381151139e-51, 1.627087215831843e-49, 2.893415694251288e-48, 5.145301553770553e-47, 9.149783811511472e-46, 1.6270872158318115e-44, 2.8934156942512736e-43, 5.1453015537705997e-42, 9.149783811511426e-41, 1.627087215831826e-39, 2.8934156942512997e-38, 5.145301553770574e-37, 9.149783811511379e-36, 1.6270872158318304e-34, 2.8934156942512852e-33, 5.145301553770547e-32, 9.149783811511462e-31, 1.6270872158318222e-29, 2.89341569425127e-28, 5.1453015537705574e-27, 9.149783811511415e-26, 1.6270872158318126e-24, 2.8934156942512966e-23, 5.145301553770531e-22, 9.149783811511368e-21, 1.6270872158318274e-19, 2.8934156942512784e-18, 5.145301553770536e-17, 9.149783811511431e-16, 1.6270872158318307e-14, 2.8934156942517593e-13, 5.14530155378523e-12, 9.149783811976453e-11, 1.6270872173025963e-9, 2.8934157407615915e-8, 5.145303024555979e-7, 9.149830322125944e-6, 0.00016272343118918593, 0.00289807662747472, 0.05298182180017686])

            @test gamma_inc_inv(0.8, p, 1.0 - p) ≈ x # test values from Wolfram Engine
        end
        @testset "q=$q" for (q, x) in zip(
            exp10.(-100:1:-1),
            [229.01881964879547, 226.71824500800236, 224.41769076456038, 222.11715733642566, 219.81664515453005, 217.51615466332387, 215.21568632134702, 212.915240601831, 210.6148179933329, 208.3144190004045, 206.0140441442978, 203.71369396371037, 201.41336901557207, 199.11306987587741, 196.81279714056546, 194.51255142645098, 192.212333372211, 189.91214363943013, 187.6119829137088, 185.31185190583992, 183.01175135305803, 180.71168202036685, 178.41164470195156, 176.1116402226816, 173.8116694397115, 171.51173324418784, 169.21183256306998, 166.91196836107474, 164.6121416427546, 162.31235345472112, 160.01260488802538, 157.7128970807092, 155.41323122054257, 153.11360854796257, 150.81403035923307, 148.51449800984503, 146.21501291817927, 143.91557656945693, 141.61619052000523, 139.31685640186856, 137.01757592779973, 134.71835089666916, 132.41918319933484, 130.1200748250212, 127.82102786826009, 125.52204453645527, 123.2231271581382, 120.92427819199246, 118.62550023673435, 116.32679604194922, 114.02816851999613, 111.72962075911023, 109.43115603785014, 107.13277784105955, 104.83448987753734, 102.5362960996409, 100.23820072508147, 97.94020826121272, 95.64232353216251, 93.34455170921704, 91.04689834493611, 88.7493694115636, 86.45197134439825, 84.15471109091378, 81.85759616656797, 79.56063471842337, 77.26383559792987, 74.9672084444988, 72.67076378184636, 70.37451312952187, 68.0784691325845, 65.78264571309141, 63.48705824795173, 61.191723778850054, 58.89666126143694, 56.601891862940285, 54.30743931994278, 52.013330371532625, 49.719595287716345, 47.426268519386156, 45.13338950500763, 42.841003681662635, 40.54916376587485, 38.25793139545992, 35.9673792617948, 33.6775939194458, 31.388679548877068, 29.1007630884523, 26.814001380698706, 24.528591362561205, 22.244785001068575, 19.962911900179556, 17.683414852456384, 15.40690839295191, 13.134280906362047, 10.866886083459129, 8.606937961095781, 6.358442041160597, 4.129879116928351, 1.9452584157780992])

            @test gamma_inc_inv(0.8, 1.0 - q, q) ≈ x # test values from Wolfram Engine
        end
    end

    @testset "a=1.8" begin
        @testset "p=$p, x=$x" for (p, x) in zip(
            0.0:0.01:1.0,
            [0.0, 0.1071755222650277, 0.16050998728955507, 0.20416656508566741, 0.24280678250939972, 0.27826797183157947, 0.31150317301391278, 0.34308358281638091, 0.37338428082062985, 0.40266774948514333, 0.43112656018759449, 0.45890727249428631, 0.48612476640606467, 0.51287131234095706, 0.53922256543527058, 0.5652416715299875, 0.5909821656505071, 0.61649007140344114, 0.64180545586647186, 0.66696360394811371, 0.69199592089152651, 0.71693063676844848, 0.7417933642658795, 0.76660754611766135, 0.7913948184012789, 0.81617530891938483, 0.84096788496285169, 0.86579036123554576, 0.89065967617260244, 0.91559204301304553, 0.94060308059774034, 0.96570792782021209, 0.99092134486698613, 1.0162578037796903, 1.04173157040596, 1.0673567794461716, 1.0931475040232679, 1.1191178209852426, 1.1452818729806347, 1.1716539282165654, 1.198248438708915, 1.2250800977595322, 1.2521638973416984, 1.2795151860393545, 1.3071497281656619, 1.3350837646807319, 1.363334076536002, 1.3919180510932918, 1.4208537523000897, 1.4501599953496895, 1.4798564266162111, 1.5099636097318834, 1.5405031187690257, 1.571497639604559, 1.6029710806837836, 1.6349486945666225, 1.6674572118386319, 1.7005249892070939, 1.7341821738873691, 1.7684608867260749, 1.8033954269180192, 1.839022501668433, 1.8753814847505423, 1.9125147086353582, 1.9504677957575041, 1.9892900355679812, 2.0290348153641435, 2.0697601145466438, 2.1115290740202663, 2.1544106550478053, 2.1984804051368831, 2.2438213526962998, 2.2905250575198943, 2.3386928510229508, 2.3884373090925655, 2.4398840121490508, 2.4931736625766741, 2.5484646505330266, 2.6059361873998439, 2.6657921648912399, 2.7282659516930696, 2.7936264154376702, 2.8621855665549849, 2.9343083789530127, 3.0104255776654698, 3.0910505401567816, 3.176802011280996, 3.2684352132712395, 3.3668853781968782, 3.4733301840058628, 3.5892819029224894, 3.7167280552758761, 3.8583548958347427, 4.0179202697917491, 4.2009145830871581, 4.4158272046973419, 4.6768376437172963, 5.0104347814570787, 5.4758322541221567, 6.2608605070659076, Inf])

            @test gamma_inc_inv(1.8, p, 1.0 - p) ≈ x # scipy.special.gammaincinv(0.4, p)
        end
        @testset "p=$p" for (p, x) in zip(
            exp10.(-100:1:-1),
            [3.707761254750258e-56, 1.3325003059446943e-55, 4.788757806527916e-55, 1.7209903237750957e-54, 6.184918540858523e-54, 2.2227444761655754e-53, 7.988129469590149e-53, 2.870784883605365e-52, 1.031706594054465e-51, 3.707761254750239e-51, 1.3325003059447063e-50, 4.788757806527892e-50, 1.7209903237750867e-49, 6.184918540858492e-49, 2.2227444761655954e-48, 7.988129469590107e-48, 2.8707848836053503e-47, 1.0317065940544597e-46, 3.707761254750272e-46, 1.3325003059446996e-45, 4.788757806527867e-45, 1.7209903237750778e-44, 6.184918540858548e-44, 2.222744476165584e-43, 7.988129469590066e-43, 2.870784883605336e-42, 1.0317065940544692e-41, 3.7077612547502536e-41, 1.3325003059446928e-40, 4.788757806527843e-40, 1.7209903237750934e-39, 6.184918540858516e-39, 2.2227444761655726e-38, 7.988129469590025e-38, 2.8707848836053617e-37, 1.0317065940544638e-36, 3.7077612547502345e-36, 1.332500305944705e-35, 4.788757806527886e-35, 1.7209903237750848e-34, 6.184918540858484e-34, 2.2227444761655928e-33, 7.988129469590212e-33, 2.870784883605347e-32, 1.0317065940544585e-31, 3.7077612547502835e-31, 1.3325003059446981e-30, 4.788757806527862e-30, 1.7209903237751003e-29, 6.184918540858527e-29, 2.222744476165581e-28, 7.988129469590148e-28, 2.8707848836053526e-27, 1.0317065940544605e-26, 3.707761254750291e-26, 1.332500305944691e-25, 4.788757806527871e-25, 1.720990323775097e-24, 6.184918540858509e-24, 2.22274447616557e-23, 7.988129469590162e-23, 2.8707848836053586e-22, 1.0317065940544627e-21, 3.707761254750298e-21, 1.3325003059446938e-20, 4.7887578065278464e-20, 1.720990323775102e-19, 6.184918540858521e-19, 2.2227444761655742e-18, 7.988129469590178e-18, 2.8707848836053435e-17, 1.0317065940544762e-16, 3.707761254750278e-16, 1.3325003059446954e-15, 4.788757806527908e-15, 1.7209903237751032e-14, 6.184918540858667e-14, 2.2227444761657655e-13, 7.988129469592387e-13, 2.8707848836082937e-12, 1.0317065940582696e-11, 3.707761254799369e-11, 1.332500306008107e-10, 4.788757807346916e-10, 1.7209903248328888e-9, 6.1849185545203925e-9, 2.2227444938105636e-8, 7.988129697483771e-8, 2.870785177941316e-7, 1.0317069742041223e-6, 3.7077661645782986e-6, 0.00001332506647261226, 0.00004788839709163751, 0.00017210961115190902, 0.0006186285140292212, 0.002224510892814824, 0.008011008196393459, 0.02900638125080896, 0.10717552226502773, 0.4311265601875946])

            @test gamma_inc_inv(1.8, p, 1.0 - p) ≈ x # test values from Wolfram Engine
        end
        @testset "q=$q" for (q, x) in zip(
            exp10.(-100:1:-1),
            [234.6996383576089, 232.38917247831384, 230.0786279198282, 227.76800309248654, 225.45729635789627, 223.1465060269237, 220.83563035757481, 218.52466755276453, 216.21361575796655, 213.90247305873677, 211.59123747810125, 209.2799069738007, 206.9684794353809, 204.6569526811193, 202.34532445477637, 200.0335924221595, 197.72175416748627, 195.4098071895332, 193.09774889755434, 190.78557660695242, 188.47328753468602, 186.1608787943909, 183.8483473911957, 181.53569021620825, 179.22290404064591, 176.90998550958406, 174.59693113529053, 172.28373729011375, 169.97040019888792, 167.65691593081525, 165.34328039078144, 163.02948931005614, 160.7155382363256, 158.4014225229985, 156.08713731772116, 153.77267755003015, 151.45803791806378, 149.14321287424443, 146.82819660983563, 144.5129830382639, 142.1975657770875, 139.88193812847535, 137.56609305804756, 135.25002317190913, 132.9337206916877, 130.61717742736406, 128.30038474765615, 125.9833335476876, 123.6660142136355, 121.34841658401253, 119.0305299071902, 116.71234279471703, 114.39384316992079, 112.07501821121055, 109.7558542894085, 107.43633689833939, 105.1164505777871, 102.79617882778689, 100.47550401305557, 98.15440725616378, 95.83286831781811, 93.5108654623377, 91.18837530606888, 88.86537264606896, 86.54183026589047, 84.21771871468448, 81.89300605509332, 79.56765757447691, 77.24163545286963, 74.91489837963213, 72.5874011089625, 70.25909394215492, 67.9299221215938, 65.5998251177483, 63.26873578561278, 60.93657936074595, 58.603272256767525, 56.26872061512901, 53.932818543112944, 51.59544595577813, 49.25646590965994, 46.91572127701213, 44.57303055399143, 42.228182516266514, 39.88092931810605, 37.53097745496711, 35.17797573976101, 32.821499018861665, 30.461025668296948, 28.095905766072033, 25.72531485448408, 23.348184623678353, 20.96309503796046, 18.568098679202915, 16.16041821138785, 13.735886695731004, 11.287809291817593, 8.804319724380372, 6.2608605070659085, 3.589281902922491])

            @test gamma_inc_inv(1.8, 1.0 - q, q) ≈ x # test values from Wolfram Engine
        end
    end

    @testset "a=0.001" begin
        @testset "p=$p, x=$x" for (p, x) in zip(
            0.0:0.01:1.0,
            [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 9.793e-320, 8.8258281996309067e-311, 5.2442064082758777e-302, 2.0885820384164982e-293, 5.6626416070015106e-285, 1.0605839281955743e-276, 1.3913463845423177e-268, 1.2952838036620446e-260, 8.6636808810333524e-253, 4.2124146389233922e-245, 1.5054592477106387e-237, 3.9965668615698637e-230, 7.9602338168240791e-223, 1.20090997348131e-215, 1.3847294830684997e-208, 1.2309060164407832e-201, 8.5045125183290383e-195, 4.6029057651609662e-188, 1.9661243539196415e-181, 6.675413023480524e-175, 1.8137947775332813e-168, 3.9697776116742062e-162, 7.0423151317779386e-156, 1.0186480541842382e-149, 1.2082919222730254e-143, 1.1817770759861981e-137, 9.5806543461731422e-132, 6.4705147650865631e-126, 3.6582023269162791e-120, 1.7394045962948254e-114, 6.9867971004491818e-109, 2.3810402190694626e-103, 6.9129343541856114e-98, 1.71669965360591e-92, 3.6603939138610754e-87, 6.7261696481112057e-82, 1.0689601189656641e-76, 1.4743519045954981e-71, 1.7706253773856427e-66, 1.85749673681364e-61, 1.7074484121414459e-56, 1.3793741591778402e-51, 9.8216596440656967e-47, 6.1811283531832712e-42, 3.447488184610534e-37, 1.7085354519424486e-32, 7.5427383121540407e-28, 2.9735875496464905e-23, 1.0493212802006967e-18, 3.3220770969837717e-14, 9.4569508903874499e-10, 2.4259428385570885e-05, Inf])

            @test gamma_inc_inv(0.001, p, 1.0 - p) ≈ x # scipy.special.gammaincinv(0.4, p)
        end
        @testset "p=$p" for p in exp10.(-100:1:-1)

            @test gamma_inc_inv(0.001, p, 1.0 - p) ≈ 0.0 # test values from Wolfram Engine
        end
        @testset "q=$q" for (q, x) in zip(
            exp10.(-100:1:-1),
            [217.967815220813, 215.675742835205, 213.383781740894, 211.0919343139162, 208.800203007102, 206.508590353414, 204.2170989694741, 201.9257315592833, 199.6344909181514, 197.3433799368501, 195.0524016060035, 192.7615590207356, 190.4708553855891, 188.1802940197381, 185.8898783625144, 183.5996119792699, 181.3094985676012, 179.0195419639628, 176.7297461506981, 174.4401152635209, 172.1506535994824, 169.8613656254612, 167.5722559872186, 165.2833295190657, 162.9945912541902, 160.7060464357006, 158.4177005284463, 156.12955923168, 153.8416284926366, 151.5539145211082, 149.2664238051048, 146.9791631276978, 144.6921395851576, 142.4053606065028, 140.1188339745982, 137.832567848949, 135.5465707903573, 133.2608517876278, 130.9754202865286, 128.6902862212401, 126.4054600485523, 124.1209527851044, 121.8367760479954, 119.552942099139, 117.2694638937849, 114.9863551336826, 112.7036303254327, 110.4213048446424, 108.1393950065919, 105.8579181442192, 103.576892694352, 101.2963382932523, 99.0162758827067, 96.7367278280874, 94.4577180500398, 92.1792721717254, 89.9014176838744, 87.6241841302904, 85.3476033169234, 83.0717095481869, 80.7965398948875, 78.522134498969, 76.2485369213003, 73.9757945399989, 71.7039590083436, 69.4330867832816, 67.1632397379705, 64.8944858748769, 62.6269001598625, 60.3605655026859, 58.0955739158008, 55.8320278917081, 53.5700420501159, 51.3097451207115, 49.0512823468178, 46.7948184215188, 44.5405411038425, 42.2886657124665, 40.0394407644635, 37.7931551264932, 35.5501471905918, 33.3108168002839, 31.0756409741101, 28.8451949679463, 26.6201809964091, 24.4014681950185, 22.1901495111923, 19.9876248547767, 17.7957263957853, 15.6169142617183, 13.4545955112044, 11.3136715926141, 9.2015398174961, 7.13007926519268, 5.12002508378954, 3.212067452, 1.5010281473, 0.26477027, 0.0000242594284, 9.82165964e-47])

            @test gamma_inc_inv(0.001, 1.0 - q, q) ≈ x # test values from Wolfram Engine
        end
    end

    @testset "a=88.6" begin
        @testset "p=$p, x=$x" for (p, x) in zip(
            0.0:0.01:1.0,
            [0.0, 68.182564057578659, 70.357062784263817, 71.760877899786948, 72.829353353366415, 73.706386972437542, 74.458490388905602, 75.12219461238017, 75.719845624365121, 76.266166586236068, 76.771402301686194, 77.242986392330991, 77.686494958669414, 78.106225421683931, 78.50556502309793, 78.887234808310836, 79.253456568431432, 79.606070310177984, 79.946618932262979, 80.276410559274709, 80.596565284301676, 80.908050799453733, 81.211709956856978, 81.508282370701906, 81.798421552199031, 82.082708649987609, 82.361663579041377, 82.635754117812908, 82.905403408390271, 83.170996189584713, 83.432884016058068, 83.691389659635405, 83.946810846256611, 84.199423449687018, 84.449484238382098, 84.697233252859277, 84.942895876083071, 85.18668464780427, 85.428800864609457, 85.669436000206872, 85.908772974675117, 86.146987296778406, 86.384248099705346, 86.620719087619619, 86.856559407959935, 87.091924462499136, 87.326966668607852, 87.561836180921006, 87.796681582652582, 88.031650555063862, 88.266890533043721, 88.502549354439552, 88.738775910585431, 88.975720805449285, 89.213537031000897, 89.45238066667676, 89.692411611339708, 89.933794356792788, 90.176698812815317, 90.421301194840566, 90.667784986823875, 90.916341993645545, 91.167173499597013, 91.420491552216376, 91.676520394081336, 91.935498069297722, 92.197678236508722, 92.463332226600599, 92.732751391148227, 93.006249797557189, 93.284167339317776, 93.566873345624515, 93.854770794832618, 94.148301262289351, 94.447950766886493, 94.754256724998356, 95.067816279076155, 95.38929634645433, 95.719445839736153, 96.059110654771956, 96.409252222677836, 96.770970703934069, 97.145534304515252, 97.534416777401361, 97.939346035676579, 98.362368106482464, 98.805932668773451, 99.273009611654814, 99.767251266034179, 100.2932237698064, 100.85674648050276, 101.46540670265372, 102.12937183070848, 102.86273396770143, 103.68587349786873, 104.62994489700357, 105.74630631344544, 107.12941611870914, 108.98632200164798, 111.9556294726119, Inf])

            @test gamma_inc_inv(88.6, p, 1.0 - p) ≈ x # scipy.special.gammaincinv(0.4, p)
        end
        @testset "p=$p" for (p, x) in zip(
            exp10.(-100:1:-1),
            [2.5852275289975455, 2.6553717610322383, 2.727478907720068, 2.8016072938321055, 2.8778171735559703, 2.956170805837097, 3.036732533340761, 3.1195688652492, 3.2047485641234585, 3.292342737076045, 3.3824249315183224, 3.4750712357659808, 3.570360384806935, 3.6683738715589054, 3.7691960639686917, 3.8729143283323673, 3.979619159244955, 4.089404316620411, 4.202366970257858, 4.3186078524683005, 4.4382314193181855, 4.561346021092065, 4.688064082627077, 4.818502294227344, 4.952781813927251, 5.091028481939436, 5.233373048197169, 5.379951413982101, 5.530904888718249, 5.686380463112416, 5.846531099931341, 6.01151604382789, 6.181501151764079, 6.356659245729633, 6.537170489622382, 6.723222792344466, 6.915012239377346, 7.112743555333063, 7.316630600241695, 7.526896902630138, 7.743776232779111, 7.967513219919468, 8.19836401755163, 8.43659702155, 8.682493646256853, 8.93634916438627, 9.198473617260905, 9.46919280270582, 9.748849348840304, 10.037803883060853, 10.336436306717722, 10.645147187382394, 10.964359282215522, 11.29451920781482, 11.636099274096011, 11.989599502296304, 12.355549850157601, 12.734512670830728, 13.127085436147913, 13.533903759765453, 13.955644761441686, 14.393030820583588, 14.846833775415758, 15.317879634005761, 15.807053875312087, 16.315307432899612, 16.843663471626066, 17.393225089256802, 17.965184101667415, 18.560831103421712, 19.1815670368719, 19.82891655491528, 20.5045435283571, 21.21026913278686, 21.948093057856397, 22.720218521934108, 23.529081958557207, 24.377388483751393, 25.268154577732393, 26.204759853417496, 27.191010385520507, 28.23121690933561, 29.330292376299376, 30.49387504230606, 31.72848573065739, 33.04173158537666, 34.442574228689004, 35.941688984608845, 37.55195589679257, 39.28914663297523, 41.17291165492147, 43.228244588378935, 45.48773828415286, 47.99522442464647, 50.811991636428644, 54.028219141888094, 57.786166124476225, 62.3341858449832, 68.18256405757906, 76.77140230168611])

            @test gamma_inc_inv(88.6, p, 1.0 - p) ≈ x # test values from Wolfram Engine
        end
        @testset "q=$q" for (q, x) in zip(
            exp10.(-100:1:-1),
            [460.2378464256347, 457.39368817427714, 454.5453619179579, 451.6927967452591, 448.83591982532414, 445.97465633575, 443.10892938698686, 440.2386599430421, 437.3637667382634, 434.4841661899616, 431.59977230662116, 428.7104965914204, 425.81624794076674, 422.91693253753357, 420.01245373865424, 417.10271195670606, 414.18760453509225, 411.2670256163905, 408.3408660034119, 405.40901301246845, 402.4713503183151, 399.52775779018066, 396.57811131825656, 393.6222826299621, 390.66013909523764, 387.691543520062, 384.71635392731326, 381.7344233240168, 378.74559945393395, 375.74972453435413, 372.7466349758453, 369.73616108359505, 366.7181267388549, 363.6923490588431, 360.6586380333105, 357.6167961357862, 354.56661790732136, 351.507889510325, 348.44038824983386, 345.36388205926954, 342.27812894742476, 339.1828764030583, 336.0778607530666, 332.9628064697557, 329.837425422197, 326.70141606608036, 323.5544625657852, 320.3962338416397, 317.22638253444546, 314.04454387834767, 310.85033447196747, 307.64335093637897, 304.4231684469754, 301.1893391244743, 297.94139026823774, 294.6788224126631, 291.40110718455696, 288.1076849360899, 284.7979621240029, 281.4713084011127, 278.1270533806659, 274.7644830275506, 271.3828356225465, 267.98129723638937, 264.55899663908104, 261.11499955610566, 257.64830216644634, 254.15782371673203, 250.6423981005071, 247.1007642202212, 243.5315549103327, 239.9332841507173, 236.30433223730427, 232.64292849750973, 228.9471310360622, 225.21480286463216, 221.4435835957665, 217.630855653116, 213.7737036447505, 209.86886513392975, 205.9126704773202, 201.9009686176503, 197.8290346151041, 193.6914531230672, 189.48196971238886, 185.1932985251464, 180.8168695321071, 176.3424905471351, 171.75788612160824, 167.04805384864318, 162.1943414689006, 157.1730814745704, 151.95349386504532, 146.4943144796431, 140.73805800209854, 134.6005200496179, 127.94961231830479, 120.55643981585999, 111.95562947261172, 100.85674648050272])

            @test gamma_inc_inv(88.6, 1.0 - q, q) ≈ x # test values from Wolfram Engine
        end
    end

    for x=-.5:.5:.9
        @test SpecialFunctions.loggamma1p(x) ≈ loggamma(1.0+x)
    end

    for x = .5:5.0:100.0
        @test SpecialFunctions.stirling_error(x) ≈ log(gamma(x)) - (x-.5)*log(x)+x- log(2*pi)/2.0
    end

    @test_throws ArgumentError("p + q must equal one but is 0.5") gamma_inc_inv(0.4, 0.2, 0.3)

    @testset "Low precision with Float64(p) + Float64(q) != 1" for T in (Float16, Float32)
        @test gamma_inc(T(1.0), gamma_inc_inv(T(1.0), T(0.1), T(0.9)))[1]::T ≈ T(0.1)
        @test gamma_inc(T(1.0), gamma_inc_inv(T(1.0), T(0.9), T(0.1)))[2]::T ≈ T(0.1)
        @test_throws ArgumentError("p + q must equal one but was 1.02") gamma_inc_inv(T(1.0), T(0.1), T(0.92))
        @test_throws ArgumentError("p + q must equal one but was 1.02") gamma_inc_inv(T(1.0), T(0.92), T(0.1))
    end
end

double(x::Real) = Float64(x)
double(x::Integer) = Int(x)
double(x::Complex) = ComplexF64(x)

@testset "upper incomplete gamma function" begin
    setprecision(BigFloat, 256) do
        for a in Any[0:0.4:3; 1:3], x in 0:0.2:2
            @test gamma(a,x) ≈ gamma(big(a),big(x))
        end
        @test_throws DomainError gamma(-2.2, -1.3)
        for (a,x, exact) in (
            (2, big"+1.3", big"0.6268231239782289871813662853957039889809398944861850589869804057956189274569818"),
            (2, big"-1.3", big"-1.100789000285773266137246974803445875429455665367265440176867948378982424804222"),
            (big"2.2", big"1.3", big"0.7550934853735524106456916078787596171599416239996064979513848803118671763945577"),
            (big"-2.2", big"1.3", big"0.03938564959393195337328006806473296774233286427565465045140458665248322893076784"),
            (big"-2.2", big"-1.3"+0im, Complex(big"0.1688350167695890519002747177035271528716667324397453142169971691104641885370081", big"-1.724677939954414412829215929952389349929001266936564849801773346878175589599461")),
            (2, big"1.3"+2im, Complex(big"0.2347744561498965806069446787000456827042253434143074251879541754828136789074293", big"-0.7967951407674886396960561446265346226800340382780520672369163777061700801594228")),
            (big"2.2", big"1.3"+2im, Complex(big"0.4226969694490623767886715572749155659150206342283251276656790859161308520476838", big"-0.9507541450333763666696561254491461255244463810462729822382144498284499948680099")),
            (big"2.2"-2im, big"1.3"+2im, Complex(big"-3.858698824275578861673404086439928163791926530897603434146764316225759116935376", big"0.2105970967650200831829566202893410569725743566037534990454186505024476246014339")),
            (30, big"-1e2", big"-2.080142496354742431762923569133534773079637504483999408076147454085194055640495e+101"),
            )
            if !(exact isa Complex) # we don't yet have a Complex{BigFloat} gamma function
                @test gamma(a, x) ≈ exact atol=eps(abs(exact))*1000
            end
            @test gamma(double(a), double(x)) ≈ double(exact) rtol=1e-13
        end
    end
    @test gamma(30, big(-1000)) ≈ big"-1.914496653187781420578078670260160511219745144309147121829045802464973219500799e+521" rtol=1e-70
    @test gamma(30, -1000) == -Inf
    @test gamma(Inf, 51.2) == Inf
    @test gamma(-Inf, -51.2) == 0.0
    @test_throws DomainError gamma(Inf, -51.2)
    @test gamma(2.3, Inf) == 0.0
    @test gamma(2, -Inf) == -Inf
    @test_throws DomainError gamma(2.2, -Inf)
end

@testset "upper incomplete gamma function logarithm" begin
    for (a,z) in ((3,5), (3,-5), (3,5+4im), (3,-5+4im), (3,5-4im), (-3,5+4im), (-3,-5+4im))
        @test exp(loggamma(a,z)) ≈ gamma(a,z) rtol=1e-13
    end
    @test loggamma(50, 1e7) ≅ -9.9992102133082030308153473164868727954977460876571275797855e6
    @test real(loggamma(50, 1e7 + 1e8im)) ≅ -9.999097142860392e6
    @test cis(imag(loggamma(50, 1e7 + 1e8im))) ≈ cis(1.0275220422549918) rtol=1e-8
    @test real(loggamma(10+20im, -1e5 + 1e8im)) ≈ 100134.3502048662475864409896160245625409130538724704329203542339
    @test cis(imag(loggamma(10+20im, -1e5 + 1e8im))) ≈ cis(-2.6572071454623347) rtol=1e-8
    @test loggamma(-1e8, 1e9) ≅ -3.0723266045132171331933746054573197040165846554476396719312e9
    @test loggamma(3, Inf) == -Inf
    @test_throws DomainError loggamma(3, -Inf)
    @test loggamma(Inf, 3.2) == Inf
    @test loggamma(-Inf, 3.2) == -Inf
    @test_throws DomainError loggamma(Inf, -3.2)
    @test loggamma(117.3, 0) == loggamma(117.3)
    @test loggamma(7, -300.2) ≅ log(gamma(7, -300.2))
    @test_throws DomainError loggamma(6, -3.2)
end
