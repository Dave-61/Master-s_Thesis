clear
clc

%V1 is the number of PSs
V1=30;
%V2 is the number of CDs
V2=8;
%V3 is the number of APs
V3=4;
%A is the truck capacity
A=100;
%********************************************************************************************************************************************************************************************************

% S(i,j) 'flow between PSi & APj'
S=[
54	48	82	68
84	45	74	72
45	81	84	76
62	83	63	51
56	49	22	66
62	58	71	49
86	39	58	67
29	85	88	47
71	37	56	84
65	26	38	58
74	52	72	82
77	88	84	24
62	36	61	67
87	28	50	75
70	82	24	44
41	31	22	71
40	53	45	30
81	69	78	70
30	69	35	86
71	90	58	73
26	78	85	39
80	31	54	25
53	64	79	34
60	82	75	28
70	79	23	21
41	24	29	73
60	87	58	53
33	20	49	76
54	39	85	69
82	68	39	70];

%C1(i,k) 'cost of travelling between PSi & CDk'
C1=[ 
0.2864	0.4135	0.1822	0.3832	0.9704	0.4752	0.6691	0.3903
0.9055	0.6478	0.1602	0.8712	0.3803	0.2773	0.0813	0.2289
0.0443	0.7702	0.0617	0.0987	0.4068	0.3087	0.7190	0.0597
0.3386	0.8237	0.1944	0.7843	0.2554	0.7034	0.3280	0.7954
0.9499	0.9721	0.6375	0.0587	0.3140	0.1009	0.7124	0.0108
0.1228	0.9582	0.9749	0.4649	0.6520	0.5390	0.2028	0.1945
0.2084	0.5209	0.8627	0.3605	0.7212	0.1535	0.6300	0.5378
0.0986	0.0936	0.3974	0.0836	0.5545	0.5825	0.2988	0.3116
0.1012	0.6592	0.0774	0.5257	0.7624	0.6124	0.3224	0.8645
0.3009	0.6704	0.8406	0.8708	0.1037	0.6590	0.3632	0.1287
0.8023	0.5341	0.9598	0.8462	0.5347	0.4755	0.9206	0.9867
0.5037	0.1192	0.6845	0.9652	0.2628	0.2376	0.9072	0.9395
0.9831	0.3299	0.4648	0.6240	0.6998	0.4475	0.1917	0.7209
0.3334	0.3610	0.6034	0.3627	0.5798	0.9951	0.3820	0.3152
0.2953	0.8155	0.9251	0.9478	0.3357	0.1539	0.2507	0.0253
0.8250	0.4624	0.3964	0.6438	0.8788	0.4355	0.2575	0.9366
0.7554	0.9972	0.6924	0.6550	0.7661	0.7971	0.1961	0.1916
0.1635	0.6888	0.1603	0.0682	0.5703	0.0028	0.8794	0.3656
0.3207	0.8238	0.0966	0.9255	0.2821	0.2625	0.4625	0.2243
0.5482	0.3796	0.9996	0.7641	0.7760	0.3427	0.2909	0.8386
0.0188	0.2693	0.0911	0.7647	0.2737	0.8810	0.2725	0.1967
0.5276	0.7100	0.5351	0.5775	0.0383	0.1566	0.7226	0.4152
0.0278	0.8722	0.6623	0.5380	0.9557	0.2065	0.5151	0.2153
0.4272	0.8907	0.3380	0.9875	0.2843	0.5881	0.9071	0.2451
0.3565	0.2765	0.0291	0.1659	0.5244	0.5635	0.8723	0.7135
0.8517	0.2632	0.2657	0.9754	0.0214	0.6193	0.1659	0.8830
0.3539	0.6125	0.5052	0.1717	0.7324	0.1873	0.1793	0.9861
0.0895	0.5994	0.6857	0.2087	0.9389	0.3421	0.9837	0.2421
0.0082	0.5428	0.3835	0.8748	0.5175	0.8391	0.3921	0.2142
0.9718	0.0825	0.7687	0.2726	0.9393	0.7553	0.8121	0.3871];

%C2(k,j) 'cost of travelling between CDk & APj'
C2=[
0.1558	0.3365	0.9197	0.7336
0.5264	0.4085	0.3473	0.0683
0.9004	0.3739	0.0371	0.8459
0.7401	0.3049	0.9750	0.2560
0.3862	0.1741	0.4605	0.9856
0.0383	0.5506	0.4579	0.4027
0.4784	0.1728	0.5029	0.9130
0.3550	0.5966	0.9411	0.3014];

%C(i,g) 'cost of travelling between PSi1 & PSi2/APj'
C=[
0.0000	0.3525	0.6224	0.7699	0.8843	0.1453	0.7981	0.7910	0.7049	0.1599	0.5147	0.9242	0.6032	0.8471	0.0113	0.2216	0.2053	0.4431	0.5872	0.0184	0.4233	0.4967	0.3103	0.7164	0.4893	0.3682	0.4041	0.8678	0.6927	0.9542	0.1899	0.1210	0.6338	0.4593
0.3525	0.0000	0.6659	0.6341	0.5839	0.4919	0.8386	0.7201	0.2696	0.0469	0.8287	0.7257	0.2769	0.1242	0.7120	0.9533	0.5640	0.8300	0.3306	0.9796	0.0193	0.4224	0.8759	0.5366	0.0308	0.1718	0.7878	0.0289	0.9021	0.9108	0.5195	0.6853	0.4941	0.2156
0.6224	0.6659	0.0000	0.0428	0.4500	0.5147	0.3446	0.7293	0.5826	0.4638	0.8330	0.8316	0.8756	0.6417	0.0920	0.9195	0.8042	0.2128	0.8831	0.4803	0.0006	0.3103	0.3550	0.9485	0.8444	0.7925	0.1245	0.8234	0.6567	0.2352	0.0527	0.8320	0.1490	0.4790
0.7699	0.6341	0.0428	0.0000	0.5111	0.1096	0.8450	0.6439	0.4575	0.9918	0.2900	0.3276	0.6372	0.5741	0.7392	0.9249	0.5127	0.0277	0.7249	0.8081	0.9873	0.1341	0.4623	0.9444	0.9961	0.0963	0.8032	0.3311	0.5950	0.1773	0.0525	0.5760	0.2062	0.7987
0.8843	0.5839	0.4500	0.5111	0.0000	0.1413	0.4602	0.5026	0.9397	0.1296	0.2801	0.0309	0.4523	0.2611	0.1233	0.6132	0.4714	0.5499	0.2997	0.6818	0.3858	0.0894	0.8731	0.6257	0.5241	0.7480	0.1340	0.5584	0.2927	0.6229	0.4641	0.1713	0.7312	0.3141
0.1453	0.4919	0.5147	0.1096	0.1413	0.0000	0.1619	0.9221	0.2837	0.0055	0.6507	0.7592	0.9006	0.4033	0.4247	0.2382	0.3957	0.5557	0.5577	0.7118	0.8044	0.0905	0.0146	0.6596	0.9632	0.2025	0.8164	0.4603	0.2008	0.4846	0.4463	0.2240	0.7254	0.3821
0.7981	0.8386	0.3446	0.8450	0.4602	0.1619	0.0000	0.6127	0.4349	0.1163	0.4145	0.2856	0.2296	0.3453	0.7365	0.3373	0.5656	0.1216	0.3878	0.0023	0.1296	0.8904	0.3709	0.2314	0.4657	0.8611	0.6536	0.9201	0.1476	0.9622	0.4609	0.8747	0.9907	0.6353
0.7910	0.7201	0.7293	0.6439	0.5026	0.9221	0.6127	0.0000	0.0773	0.9346	0.4337	0.4826	0.6266	0.1636	0.6402	0.5298	0.8721	0.3832	0.3452	0.4997	0.5747	0.5083	0.4934	0.7254	0.8949	0.7616	0.4331	0.2027	0.5832	0.6982	0.1477	0.5224	0.2353	0.6440
0.7049	0.2696	0.5826	0.4575	0.9397	0.2837	0.4349	0.0773	0.0000	0.2432	0.0603	0.1426	0.6595	0.6683	0.0268	0.6981	0.4519	0.4371	0.0149	0.3057	0.3146	0.6578	0.3611	0.8183	0.7549	0.7961	0.0897	0.9275	0.8542	0.8177	0.7856	0.8222	0.5204	0.3929
0.1599	0.0469	0.4638	0.9918	0.1296	0.0055	0.1163	0.9346	0.2432	0.0000	0.4094	0.5593	0.5625	0.9008	0.1790	0.3717	0.5222	0.4883	0.0333	0.5355	0.6477	0.3563	0.4602	0.6781	0.7996	0.0166	0.4204	0.5681	0.2785	0.8745	0.5316	0.1288	0.8083	0.3483
0.5147	0.8287	0.8330	0.2900	0.2801	0.6507	0.4145	0.4337	0.0603	0.4094	0.0000	0.7437	0.2625	0.3001	0.0442	0.5452	0.8530	0.3614	0.9700	0.4686	0.9140	0.1447	0.7052	0.2299	0.1534	0.6465	0.6870	0.8218	0.8025	0.0039	0.7540	0.6746	0.8483	0.4825
0.9242	0.7257	0.8316	0.3276	0.0309	0.7592	0.2856	0.4826	0.1426	0.5593	0.7437	0.0000	0.4980	0.8350	0.5638	0.6303	0.8220	0.4183	0.0672	0.9609	0.1055	0.0554	0.4211	0.3416	0.6711	0.2727	0.6106	0.2537	0.1669	0.9605	0.8044	0.8317	0.1868	0.9764
0.6032	0.2769	0.8756	0.6372	0.4523	0.9006	0.2296	0.6266	0.6595	0.5625	0.2625	0.4980	0.0000	0.6795	0.4060	0.1360	0.8711	0.5328	0.9466	0.7382	0.9532	0.6563	0.6939	0.8005	0.1791	0.4293	0.1333	0.6426	0.4566	0.3487	0.8851	0.0022	0.9311	0.7188
0.8471	0.1242	0.6417	0.5741	0.2611	0.4033	0.3453	0.1636	0.6683	0.9008	0.3001	0.8350	0.6795	0.0000	0.1461	0.5293	0.7367	0.1857	0.0433	0.4399	0.4131	0.0808	0.9517	0.9755	0.3015	0.4020	0.9434	0.6867	0.8064	0.2369	0.9100	0.5219	0.4210	0.7397
0.0113	0.7120	0.0920	0.7392	0.1233	0.4247	0.7365	0.6402	0.0268	0.1790	0.0442	0.5638	0.4060	0.1461	0.0000	0.8795	0.6817	0.5344	0.3713	0.1304	0.5967	0.6504	0.0960	0.2733	0.7485	0.2530	0.6085	0.2819	0.1568	0.2140	0.3881	0.7070	0.4747	0.8197
0.2216	0.9533	0.9195	0.9249	0.6132	0.2382	0.3373	0.5298	0.6981	0.3717	0.5452	0.6303	0.1360	0.5293	0.8795	0.0000	0.9580	0.4924	0.7252	0.4770	0.3304	0.6666	0.6109	0.3918	0.5434	0.5492	0.9428	0.0652	0.8102	0.6131	0.1034	0.8861	0.1726	0.7845
0.2053	0.5640	0.8042	0.5127	0.4714	0.3957	0.5656	0.8721	0.4519	0.5222	0.8530	0.8220	0.8711	0.7367	0.6817	0.9580	0.0000	0.8998	0.1287	0.5567	0.3340	0.7723	0.8363	0.6391	0.2010	0.2471	0.2727	0.3192	0.3031	0.9439	0.2266	0.9647	0.3701	0.5855
0.4431	0.8300	0.2128	0.0277	0.5499	0.5557	0.1216	0.3832	0.4371	0.4883	0.3614	0.4183	0.5328	0.1857	0.5344	0.4924	0.8998	0.0000	0.4037	0.9620	0.9646	0.8854	0.2999	0.8119	0.1407	0.7063	0.5335	0.2811	0.8908	0.5571	0.5780	0.4847	0.8699	0.1923
0.5872	0.3306	0.8831	0.7249	0.2997	0.5577	0.3878	0.3452	0.0149	0.0333	0.9700	0.0672	0.9466	0.0433	0.3713	0.7252	0.1287	0.4037	0.0000	0.8169	0.0043	0.5193	0.3273	0.0749	0.2517	0.8787	0.8394	0.3714	0.6223	0.5391	0.5459	0.8906	0.8902	0.8051
0.0184	0.9796	0.4803	0.8081	0.6818	0.7118	0.0023	0.4997	0.3057	0.5355	0.4686	0.9609	0.7382	0.4399	0.1304	0.4770	0.5567	0.9620	0.8169	0.0000	0.2939	0.2394	0.9596	0.7496	0.5272	0.0292	0.8875	0.6871	0.1634	0.1314	0.0768	0.0004	0.8498	0.5681
0.4233	0.0193	0.0006	0.9873	0.3858	0.8044	0.1296	0.5747	0.3146	0.6477	0.9140	0.1055	0.9532	0.4131	0.5967	0.3304	0.3340	0.9646	0.0043	0.2939	0.0000	0.9669	0.7025	0.3654	0.7647	0.2283	0.8120	0.6131	0.5050	0.4194	0.4648	0.6884	0.1184	0.4602
0.4967	0.4224	0.3103	0.1341	0.0894	0.0905	0.8904	0.5083	0.6578	0.3563	0.1447	0.0554	0.6563	0.0808	0.6504	0.6666	0.7723	0.8854	0.5193	0.2394	0.9669	0.0000	0.2243	0.6397	0.0771	0.2605	0.6581	0.0812	0.0751	0.0466	0.4904	0.6286	0.2381	0.1557
0.3103	0.8759	0.3550	0.4623	0.8731	0.0146	0.3709	0.4934	0.3611	0.4602	0.7052	0.4211	0.6939	0.9517	0.0960	0.6109	0.8363	0.2999	0.3273	0.9596	0.7025	0.2243	0.0000	0.0139	0.7296	0.4908	0.1279	0.1350	0.3406	0.9655	0.3435	0.7540	0.0023	0.1062
0.7164	0.5366	0.9485	0.9444	0.6257	0.6596	0.2314	0.7254	0.8183	0.6781	0.2299	0.3416	0.8005	0.9755	0.2733	0.3918	0.6391	0.8119	0.0749	0.7496	0.3654	0.6397	0.0139	0.0000	0.4790	0.6570	0.1092	0.2353	0.3752	0.3672	0.1790	0.9176	0.5977	0.0194
0.4893	0.0308	0.8444	0.9961	0.5241	0.9632	0.4657	0.8949	0.7549	0.7996	0.1534	0.6711	0.1791	0.3015	0.7485	0.5434	0.2010	0.1407	0.2517	0.5272	0.7647	0.0771	0.7296	0.4790	0.0000	0.1953	0.1425	0.4557	0.1503	0.4663	0.4192	0.2336	0.7116	0.3034
0.3682	0.1718	0.7925	0.0963	0.7480	0.2025	0.8611	0.7616	0.7961	0.0166	0.6465	0.2727	0.4293	0.4020	0.2530	0.5492	0.2471	0.7063	0.8787	0.0292	0.2283	0.2605	0.4908	0.6570	0.1953	0.0000	0.5482	0.5116	0.1536	0.8899	0.9865	0.8459	0.4570	0.9676
0.4041	0.7878	0.1245	0.8032	0.1340	0.8164	0.6536	0.4331	0.0897	0.4204	0.6870	0.6106	0.1333	0.9434	0.6085	0.9428	0.2727	0.5335	0.8394	0.8875	0.8120	0.6581	0.1279	0.1092	0.1425	0.5482	0.0000	0.1250	0.8744	0.4770	0.7150	0.2230	0.6517	0.8757
0.8678	0.0289	0.8234	0.3311	0.5584	0.4603	0.9201	0.2027	0.9275	0.5681	0.8218	0.2537	0.6426	0.6867	0.2819	0.0652	0.3192	0.2811	0.3714	0.6871	0.6131	0.0812	0.1350	0.2353	0.4557	0.5116	0.1250	0.0000	0.0762	0.5162	0.1720	0.8990	0.9965	0.5193
0.6927	0.9021	0.6567	0.5950	0.2927	0.2008	0.1476	0.5832	0.8542	0.2785	0.8025	0.1669	0.4566	0.8064	0.1568	0.8102	0.3031	0.8908	0.6223	0.1634	0.5050	0.0751	0.3406	0.3752	0.1503	0.1536	0.8744	0.0762	0.0000	0.0932	0.8692	0.7312	0.7519	0.8740
0.9542	0.9108	0.2352	0.1773	0.6229	0.4846	0.9622	0.6982	0.8177	0.8745	0.0039	0.9605	0.3487	0.2369	0.2140	0.6131	0.9439	0.5571	0.5391	0.1314	0.4194	0.0466	0.9655	0.3672	0.4663	0.8899	0.4770	0.5162	0.0932	0.0000	0.5399	0.3394	0.7114	0.5755
0.1899	0.5195	0.0527	0.0525	0.4641	0.4463	0.4609	0.1477	0.7856	0.5316	0.7540	0.8044	0.8851	0.9100	0.3881	0.1034	0.2266	0.5780	0.5459	0.0768	0.4648	0.4904	0.3435	0.1790	0.4192	0.9865	0.7150	0.1720	0.8692	0.5399	0.0000	0.3876	0.9351	0.6706
0.1210	0.6853	0.8320	0.5760	0.1713	0.2240	0.8747	0.5224	0.8222	0.1288	0.6746	0.8317	0.0022	0.5219	0.7070	0.8861	0.9647	0.4847	0.8906	0.0004	0.6884	0.6286	0.7540	0.9176	0.2336	0.8459	0.2230	0.8990	0.7312	0.3394	0.3876	0.0000	0.1132	0.8110
0.6338	0.4941	0.1490	0.2062	0.7312	0.7254	0.9907	0.2353	0.5204	0.8083	0.8483	0.1868	0.9311	0.4210	0.4747	0.1726	0.3701	0.8699	0.8902	0.8498	0.1184	0.2381	0.0023	0.5977	0.7116	0.4570	0.6517	0.9965	0.7519	0.7114	0.9351	0.1132	0.0000	0.8329
0.4593	0.2156	0.4790	0.7987	0.3141	0.3821	0.6353	0.6440	0.3929	0.3483	0.4825	0.9764	0.7188	0.7397	0.8197	0.7845	0.5855	0.1923	0.8051	0.5681	0.4602	0.1557	0.1062	0.0194	0.3034	0.9676	0.8757	0.5193	0.8740	0.5755	0.6706	0.8110	0.8329	0.0000];

%***************************************************************************************************************************************************************************************************

%PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
T0=1; sai=10; ll=100; alfa=0.9;

iteration=4000;HMCR=0.9;PAR=0.5; 

NMRS=0.05; neighboor2_1=0.33;neighboor2_2=0.66;
%PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
 
tic

%T0 is the initial temprature used in SA % sai is the number of iteration in SA and ll is the level length
% Building the temprature matrix T
T=zeros(sai,1);
T(1)=T0;
for t=2:sai
    T(t)=T(t-1)*alfa;
end

nozeroMR=1;
%C_PS is the reduced matrix of C: Cost of traveelling between just PS's
%(PSi1 & PSi2)
C_PS=C;
C_PS(V1+1:V1+V3,:)=[];
C_PS(:,V1+1:V1+V3)=[];

%We need matrix C_PS in just 1 Column:
C_PS1C=C_PS(:,1);
for a=2:V1
    C_PS1C=[C_PS1C;C_PS(:,a)];
end
%Notice: C_PS1C(x)=C_PS(x)

[srtn,srtp]=sort(C_PS1C); %srtp shows the order of travelling cost between PSs from min to max
srtp(1:V1,:)=[];  %The first V1 row shows the cost of travelling between one PS and itself (0). It should be omited.

if srtp(1)-(floor(srtp(1)/V1))*V1==0
    MR1=[V1,floor(srtp(1)/V1)];
else
    MR1=[srtp(1)-(floor(srtp(1)/V1))*V1,floor(srtp(1)/V1)+1];
end
for a=2:V1*V1-V1
    if srtp(a)-(floor(srtp(a)/V1))*V1==0
        MR1=[MR1;V1,floor(srtp(a)/V1)];
    else
        MR1=[MR1;srtp(a)-(floor(srtp(a)/V1))*V1,floor(srtp(a)/V1)+1];
    end
end
%MR1 shows the pairs of PSs that have the least travelling cost between themselves from min to max

%We add V3 columns with numer 1 to the matrix MR1 which represents the APs
for a=1:V3
    MR1=[MR1,ones(V1*V1-V1,1)];
end

%We must determine the paris that the sum of their flows to APj exeeds the truck capacity
for d=1:V3
    for a=1:V1*V1-V1
        if S(MR1(a,1),d)+S(MR1(a,2),d)>A
            MR1(a,2+d)=0;
        end
    end
end
MR1;
MM=MR1;   % Matrix MR1 has been made.

MX=[0];
for d=3:V3+2
    MX=[MX,sum(MM(:,d))];
end
MX(1)=[];

MRtotal=zeros(V1*V1-V1,1);
for d=1:V3
    MRtotal=[MRtotal,MM(:,1:2),MM(:,d+2)];
end
MRtotal(:,1)=[];

for d=1:V3
    mr=MRtotal(:,((d*3)-2):(((d*3)-2)+2));
    szx=size(mr);i=1;
    while i<=szx(1)
        if mr(i,3)==0
            mr(i,:)=[];
            szx=size(mr);
        else
            i=i+1;
        end
    end 
    szy=size (mr);
    MRtotal(1:szy(1),((d*3)-2):(((d*3)-2)+2))=mr;
    if V1*V1-V1>szy(1)
        MRtotal(szy(1)+1:V1*V1-V1,((d*3)-2):(((d*3)-2)+2))=0;
    end
end
MRtotal;

mx=max(MX);
if V1*V1-V1>mx
    MRtotal(mx+1:V1*V1-V1,:)=[];
end
MRtotal
MX
OUTPUT1=MRtotal;
OUTPUT2=MX;
    
HSMR=zeros(21,V3);
HSMR(1,:)=1;
for d=1:V3
    HSMR(21,d)=MX(d);
    HSMR(2,d)=MX(d)/20;
end
for d=1:V3
    for l=3:20
        HSMR(l,d)=HSMR(l-1,d)+HSMR(2,d);
    end
end
for d=1:V3
    for l=2:20
        flr=floor(HSMR(l,d));
        if HSMR(l,d)~=flr
            if HSMR(l,d)-flr>=0.5
                HSMR(l,d)=flr+1;
            else
                HSMR(l,d)=flr;
            end
        end    
    end
end
HSMR
OUTPUT3=HSMR; % Shows hom many elements of matrix MR should participate in makaing a Milk Run trip

% STOPPOINT1
PNM=[1,2;1,3;1,4;1,5;1,6;1,7;1,8;1,9;1,10;1,11;1,12;1,13;1,14;1,15;1,16;1,17;1,18;1,19;1,20;1,21];
S_FF=[0];BEST_FF=1000000000000000000000000000000000000000000000000;
HSAM=zeros(V3+1,1);

for pn=1:21
display(['Population NO.: ',num2str(pn)])
    
MR2=[0];LP=zeros(V1,V3);  %LP shows the Logistics Pattern of each PSi to APj: 3:Direct shipment 2:shipment through CD 1:shipment through Milk Run
for d=1:V3
    
    if pn==21
        break
    else
        MR=MRtotal(1:MX(d),((d*3)-2):(((d*3)-2)+2));
    end
    
     
    HSMRstt=HSMR(PNM(pn,1),d),HSMRfin=HSMR(PNM(pn,2),d),
        
    j=0;
    for a=HSMRstt:HSMRfin
        if sum(sum(MR(a:HSMRfin,3)))==0
            break
        end
        nesh=0;
        if MR(a,3)==1
            nesh=1;
            j=j+1;
            ex=[MR(a,1),MR(a,2)]
            
            LP(MR(a,1),d)=1;LP(MR(a,2),d)=1;
            
            jam=S(ex(1),d)+S(ex(2),d);
            MR(a,3)=j+(d*1000);
            for b=HSMRstt:HSMRfin
                if (MR(b,1)==ex(2)&MR(b,2)==ex(1)) | MR(b,1)==ex(1) | MR(b,2)==ex(2)
                    MR(b,3)=0;
                end
            end
            
            for b=HSMRstt:HSMRfin
                ind=0;sz=size(ex);
                if (MR(b,1)==ex(sz(2))&MR(b,2)==ex(1)) | MR(b,1)==ex(1) | MR(b,2)==ex(sz(2))
                    MR(b,3)=0;
                end
                if MR(b,3)==1 & MR(b,1)==ex(sz(2))
                    if S(MR(b,2),d)+jam<=A 
                        MR(b,3)=j+(d*1000);
                        jam=jam+S(MR(b,2),d);
                        ex2=[MR(b,1),MR(b,2)];ind=2;
                        
                        LP(MR(b,1),d)=1;LP(MR(b,2),d)=1;
                        
                        for e=HSMRstt:HSMRfin
                            if (MR(e,1)==ex2(2)&MR(e,2)==ex2(1)) | MR(e,1)==ex2(1) | MR(e,2)==ex2(2)
                                MR(e,3)=0;
                            end
                        end
                    else
                        MR(b,3)=0;
                    end
                elseif MR(b,3)==1 & MR(b,2)==ex(1)
                    if S(MR(b,1),d)+jam<=A 
                        MR(b,3)=j+(d*1000);
                        jam=jam+S(MR(b,1),d);
                        ex3=[MR(b,1),MR(b,2)];ind=3;
                        
                        LP(MR(b,1),d)=1;LP(MR(b,2),d)=1;
                        
                        for e=HSMRstt:HSMRfin
                            if (MR(e,1)==ex3(2)&MR(e,2)==ex3(1)) | MR(e,1)==ex3(1) | MR(e,2)==ex3(2)
                                MR(e,3)=0;
                            end
                        end
                    else
                        MR(b,3)=0;
                    end
                end
                if ind==2
                    ex=[ex,MR(b,2)]
                elseif ind==3
                    ex=[MR(b,1),ex]
                end
            end 
        end
        if nesh==1
            MR2=[MR2,j+(d*1000),ex]
            siz=size(ex);
            for f=a+1:MX(d)
                if MR(f,1)==ex(siz(2)) | MR(f,2)==ex(1)
                    MR(f,3)=0;
                end
            end
        end
        MR;   
    % STOPPOINT2     
    end
end
MR2(1)=[]
  
% STOPPOINT3
MR3=MR2;
szm=size(MR2);
if szm~=0
    for sh1=1:szm(2)
        if MR2(sh1)>1000
            sh2=sh1+1;
            while MR2(sh2)<1000
                if sh2==szm(2)
                    break
                end
                sh2=sh2+1;
            end
             if sh2==szm(2)& C(MR2(sh1+1),V1+floor(MR2(sh1)/1000))<C(MR2(sh2),V1+floor(MR2(sh1)/1000))
                ch1=MR2(sh1+1);
                ch2=MR2(sh2);
                MR3(sh1+1)=ch2;
                MR3(sh2)=ch1;
             elseif C(MR2(sh1+1),V1+floor(MR2(sh1)/1000))<C(MR2(sh2-1),V1+floor(MR2(sh1)/1000))
                ch1=MR2(sh1+1);
                ch2=MR2(sh2-1);
                MR3(sh1+1)=ch2;
                MR3(sh2-1)=ch1;
            end
        end
    end
end
MR3
LP  

% STOPPOINT4
COST_DS=[0];COST_CD=[0];COST_MR=[0];PS_CD=zeros(V1,V2);CD_AP=zeros(V2,V3);
for a=1:V3
    for b=1:V1
        if LP(b,a)==0
            cip=[0];
            for e=1:V2
                cip=[cip,C1(b,e)+((S(b,a)/A)*C2(e,a))];
            end
            cip(1)=[];
            [p,q]=sort(cip);
            if p(1)<C(b,a+V1)
                LP(b,a)=2000+q(1);
                
                PS_CD(b,q(1))=PS_CD(b,q(1))+S(b,a);
                CD_AP(q(1),a)=CD_AP(q(1),a)+S(b,a);
                
            else
                LP(b,a)=3;
                
                COST_DS=[COST_DS,C(b,a+V1)];
                
            end
        end
    end
end
LP

% STOPPOINT5
fn=find(MR3>1000);
szfn=size(fn);
szmr=size(MR3);
MR3_R=MR3; 
if szmr~=0
    for a=1:szfn(2)-1
        MR3_R(fn(a+1))=MR3(fn(a));
    end
    MR3_R=[MR3_R,MR3(fn(szfn(2)))];
    MR3_R(1)=[];
    
    for a=1:szmr(2)-1
        if MR3_R(a)<1000 & MR3_R(a+1)<1000
            COST_MR=[COST_MR,C(MR3_R(a),MR3_R(a+1))];
        elseif MR3_R(a)<1000 & MR3_R(a+1)>1000
            COST_MR=[COST_MR,C(MR3_R(a),V1+floor(MR3_R(a+1)/1000))];
        end
    end
end
MR3_R;

PS_CD;M=PS_CD;
CD_AP;N=CD_AP;

if sum(sum(PS_CD))~=0
    for a=1:V1*V2
        if PS_CD(a)~=0
            M(a)=floor(PS_CD(a)/A)+1;
            
            COST_CD=[COST_CD,M(a)*C1(a)];
            
        end
    end
end
if sum(sum(CD_AP))~=0
    for b=1:V2*V3
        if CD_AP(b)~=0
            N(b)=floor(CD_AP(b)/A)+1;
            
            COST_CD=[COST_CD,N(b)*C2(b)];
            
        end
    end
end
M;N;

sum(COST_DS);sum(COST_CD);sum(COST_MR);COST=sum(COST_DS)+sum(COST_CD)+sum(COST_MR);SUBCOST=sum(COST_DS)+sum(COST_CD);
display(['The cost of MR tips: ',num2str(sum(COST_MR))])
display(['The cost of DIRECT & INDIRECT shipments before SA: ',num2str(SUBCOST)])
display(['The TOTAL cost before SA: ',num2str(COST)])

% STOPPOINT6
BEST_SUBCOST=SUBCOST;
BEST_M=M;BEST_N=N;BEST_LP=LP;
S_SUBCOST=[0];S_SUBCOST=[S_SUBCOST,SUBCOST];

%*************************************************** Making a good initial solution has finished **************************************************    

 
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ Simulated Annealing $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
for SAI=1:sai
    for LL=1:ll
        %We want to make a neighbour matrix for LP randomly in a way that MR trips do not change (for using in the SA)
        LPnew=LP;
        for e=1:V3
            cds=[0];
            for f=1:V1
                if LP(f,e)>1
                    cds=[cds;f];
                end
            end
            cds(1)=[];
            szcds=size(cds);
            if szcds(1)~=0
                rnd1=randint(1,1,[1,szcds(1)]);
                if LP(cds(rnd1),e)==3 %Direct Shipment
                    rnd2=randint(1,1,[1,V2]);
                    LPnew(cds(rnd1),e)=2000+rnd2;
                else   %Shipment through CD
                    bagh=LP(cds(rnd1),e)-2000;
                    rnd3=randint(1,1,[1,V2+1]);
                    while rnd3==bagh
                        rnd3=randint(1,1,[1,V2+1]);
                    end
                    if rnd3==V2+1
                        LPnew(cds(rnd1),e)=3;
                    else
                        LPnew(cds(rnd1),e)=2000+rnd3;
                    end
                end
            end           
        end
        LPnew;  %New LP with the same MR trips

        % We want to calculate the cost of new LP. NOTICE: COST_MR has NOT changed
        COST_DSnew=[0];COST_CDnew=[0];PS_CDnew=zeros(V1,V2);CD_APnew=zeros(V2,V3);
        for a=1:V3
            for b=1:V1
                if LPnew(b,a)>2000
                    e=LPnew(b,a)-2000; % e shows the CDe
                    PS_CDnew(b,e)=PS_CDnew(b,e)+S(b,a);
                    CD_APnew(e,a)=CD_APnew(e,a)+S(b,a);   
                elseif LPnew(b,a)==3
                    COST_DSnew=[COST_DSnew,C(b,a+V1)];  
                end
            end
        end

        Mnew=PS_CDnew;
        Nnew=CD_APnew;
        if sum(sum(PS_CDnew))~=0
            for a=1:V1*V2
                if PS_CDnew(a)~=0
                    Mnew(a)=floor(PS_CDnew(a)/A)+1;
                    COST_CDnew=[COST_CDnew,Mnew(a)*C1(a)];
                end
            end
        end
        if sum(sum(CD_APnew))~=0
            for b=1:V2*V3
                if CD_APnew(b)~=0
                    Nnew(b)=floor(CD_APnew(b)/A)+1;
                    COST_CDnew=[COST_CDnew,Nnew(b)*C2(b)];
                end
            end
        end
        Mnew;Nnew;
        %COST_MR has NOT changed!
        sum(COST_DSnew);sum(COST_CDnew);sum(COST_MR);SUBCOSTnew=sum(COST_DSnew)+sum(COST_CDnew);
        
        if SUBCOSTnew<BEST_SUBCOST
            BEST_SUBCOST=SUBCOSTnew;
            BEST_M=Mnew;BEST_N=Nnew;BEST_LP=LPnew;
        end
        
        if SUBCOSTnew<SUBCOST
            LP=LPnew;
            SUBCOST=SUBCOSTnew;
            %display('LP has changed')
        elseif SUBCOSTnew>SUBCOST
            if rand<exp(-(SUBCOSTnew-SUBCOST)/T(SAI))
                LP=LPnew;
                SUBCOST=SUBCOSTnew;
                %display('LP has changed')
            end
        end

        S_SUBCOST=[S_SUBCOST,SUBCOST];
        
        
    end
end

display('----------------------------------------------------------------')
display('The best LP after SA:')
BEST_LP
display(['The best cost of DIRECT & INDIRECT shipments after SA: ',num2str(BEST_SUBCOST)])
S_SUBCOST(1)=[];
%plot(S_SUBCOST)
FF=sum(COST_MR)+BEST_SUBCOST;
display(['The TOTAL cost after SA: ',num2str(FF)])
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ end of Simulated Annealing $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

% STOPPOINT7 
S_FF=[S_FF;FF];

% We want to make the HSAM matrix:
hsam=zeros(V3+1,2);
if pn~=21
    for d=1:V3
        hsam(d,1)=1;
        hsam(d,2)=HSMR(pn+1,d);
    end
    hsam(V3+1,1)=FF;hsam(V3+1,2)=FF;
    HSAM=[HSAM,hsam];

else % pn==21
    for d=1:V3
        hsam(d,1)=0;
        hsam(d,2)=0;
    end
    hsam(V3+1,1)=FF;hsam(V3+1,2)=FF;
    HSAM=[HSAM,hsam];    
end

if FF<BEST_FF
    BEST_FF=FF;
    GLOBALBEST_LP=BEST_LP;
    BEST_MR=MR3;
    BEST_COST_MR=sum(COST_MR);
    GLOBALBEST_SUBCOST=BEST_SUBCOST;
end
    

display('******************************************************** END OF A POPULATION ***************************************************************')
end
display('************************************************* The initial matrix HSAM has been made ****************************************************')
HSAM(:,1)=[]
OUTPUT4=HSAM;
S_FF(1)=[]

costantimilkrun=S_FF(21);

[m,n]=sort(S_FF);
if n(1)==21;
    bfp=0; %The best cost of initial population is related to NoMilkRun shipment
    bestfirstpopulation=m(2);
else
    bfp=1; %The best cost of initial population is related to a MilkRun shipment
    bestfirstpopulation=m(1);
end

FF_plot=bestfirstpopulation;

BEST_FF
MRtotal

figure(1)
plot(S_FF)
xlabel('No.')
ylabel('Cost')
title('Initial Population')

display ('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END OF INITIAL POPULATION MAKING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
 

% STOPPOINT11
S_FF(21)=[]; % we omit the cost of only direct and indirect shipments
 
AVERAGE=[sum(S_FF)/20];
 
copcounter=0; % change of population counter
    
for mitn=1:iteration 
   display(['Iteration: ',num2str(mitn)])
   
   birand=randint(1,1,[1,20])
   
newsolution=HSAM(1:V3,2*birand-1:2*birand) 
               
% ################################################################## PHASE ONE 1 ################################################################   
display('PHASE ONE 11111111111111111111111111111111111111111111111111111111111111111')
  
             
MR2=[0];LP=zeros(V1,V3);MRtotalnew=zeros(mx,1);

for d=1:V3
    display(['ROW: ',num2str(d)])
    
    if newsolution(d,1)~=newsolution(d,2)
            
        rndhm=rand;
        if rndhm<HMCR
            rndpar=rand;
            
            if rndpar<PAR %Pitch Adjustment Rate
                display('Pitch Adjustment')
                dist=floor(MX(d)/30)+1;
                sumrand=randint(1,1,[1,dist]);
                rndek=rand;
                if rndek<0.5
                    newsolution(d,2)=newsolution(d,2)-sumrand;
                    if newsolution(d,2)<2
                        newsolution(d,2)=2;
                    end
                else
                    newsolution(d,2)=newsolution(d,2)+sumrand;
                    if newsolution(d,2)>MX(d)
                        newsolution(d,2)=MX(d);
                    end
                end
                newsolution(d,:)
                
            else
                display('No Pitching')
            end
            
        else % rndhm<1-HMCR : Random
            display('Random')
            newsolution(d,2)=randint(1,1,[2,MX(d)]);
            newsolution(d,:)
        end

        
        MR=MRtotal(:,((d*3)-2):(((d*3)-2)+2));
        if newsolution(d,2)-newsolution(d,1)==1
            rep1=newsolution(d,1);rep2=newsolution(d,2);
        else
            rep1=-4;rep2=-4;
            while rep1==rep2
                rep1=randint(1,1,[newsolution(d,1)+1,newsolution(d,2)])
                rep2=randint(1,1,[newsolution(d,1),newsolution(d,2)])
            end
        end
        SW1=MR(rep1,:);
        SW2=MR(rep2,:);
        rndnh=rand;
    
        if rndnh<=neighboor2_1  % INSERTION MOVE 
            display('INSERTION MOVE')
            repmax=max(rep1,rep2);repmin=min(rep1,rep2);
            SW11=MR(repmin,:);SW12=MR(repmax,:);
            mr_resized1=MR(1:repmin-1,:);    
            mr_resized2=MR(repmin+1:repmax-1,:);    
            mr_resized3=MR(repmax+1:mx,:);  
            if repmin==1     
                MR=[SW12;SW11;mr_resized2;mr_resized3]; 
            else
                MR=[mr_resized1;SW12;SW11;mr_resized2;mr_resized3];
            end

        elseif rndnh<=neighboor2_2  % SWAP MOVE
            display('SWAP MOVE')    
            MR(rep1,:)=SW2;   
            MR(rep2,:)=SW1;
    
        else   % 2_OPT MOVE
            display('2_OPT MOVE')
            repmax=max(rep1,rep2);repmin=min(rep1,rep2);
            if repmin==1         
                mr_resized2=MR(repmax+1:mx,:);  
                mr_change=zeros(repmax-repmin+1,3);
                for k=1:repmax-repmin+1
                    mr_change(k,:)=MR(repmax-(k-1),:);
                end
                MR=[mr_change;mr_resized2];
            else
                mr_resized1=MR(1:repmin-1,:);
                mr_resized2=MR(repmax+1:mx,:); 
                mr_change=zeros(repmax-repmin+1,3);
                for k=1:repmax-repmin+1
                    mr_change(k,:)=MR(repmax-(k-1),:);
                end
                MR=[mr_resized1;mr_change;mr_resized2];
            end
        end

        MRtotalnew=[MRtotalnew,MR];
    
    else % It means that: we don't have any Milk Run trips for APd
        display('No Movement in matrix MRtotal')
        MRtotalnew=[MRtotalnew,MRtotal(:,((d*3)-2):(((d*3)-2)+2))];
    end

    display('----------------------------------')
    
end
       
MRtotalnew(:,1)=[];

% ################################################################ END OF PHASE ONE 1 ##########################################################    
         
 
% ################################################################## PHASE TWO 2 #################################################################
display('PHASE TWO 2222222222222222222222222222222222222222222222222222222222222222222') 
MRtotaloriginal=MRtotal;
MRtotal=MRtotalnew;  
 
newsolution=zeros(V3,2);
    
for d=1:V3   
    
    dist=floor(MX(d)/30)+1;    
    mindist=min(MX(d)-HSAM(d,(2*birand)),HSAM(d,(2*birand)-1)-1)+1;   
    randnmrs=rand;
           
    if  HSAM(d,(2*birand))-HSAM(d,(2*birand)-1)==0   %%%%%% no difference (=0) %%%%%%
                  
        if randnmrs<NMRS    % no difference (=0) & no milk run shipment    
            display('no difference (=0) & no milk run shipment')     
            newsolution(d,1)=HSAM(d,(2*birand)-1);       
            newsolution(d,2)=HSAM(d,(2*birand));    
            
        else  % no difference (=0) + milk run shipment     
            display('no difference (=0) + milk run shipment')      
            if HSAM(d,(2*birand))==1 & HSAM(d,(2*birand)-1)==1    
                sumrand=randint(1,1,[1,dist]);     
                newsolution(d,1)=1;   
                newsolution(d,2)=1+sumrand;
            else
                newsolution(d,1)=HSAM(d,(2*birand)-1)-randint(1,1,[1,mindist]);   
                newsolution(d,2)=HSAM(d,(2*birand))+randint(1,1,[1,mindist]);    
                if newsolution(d,1)<0 | newsolution(d,1)==0      
                    newsolution(d,1)=1;
                end   % newsolution(d,1)===1  
                if newsolution(d,2)>MX(d)    
                    newsolution(d,2)=MX(d);
                end
            end
        end

    else     %%%%%% difference >=1 %%%%%%      
            
        if HSAM(d,(2*birand))-HSAM(d,(2*birand)-1)==1 & randnmrs<NMRS % 0ne unit difference ([1,2]) & no milk run shipment  
            display('0ne unit difference & no milk run shipment ') 
            newsolution(d,1)=HSAM(d,(2*birand)-1)+1; 
            newsolution(d,2)=newsolution(d,1); % ===2  
            
        elseif HSAM(d,(2*birand))-HSAM(d,(2*birand)-1)==1   % one unit difference ([1,2]) + milk run shipment    
            display('one unit difference + milk run shipment ')    
            if HSAM(d,(2*birand)-1)==1 & HSAM(d,(2*birand))==2 
                sumrand=randint(1,1,[1,dist]);  
                newsolution(d,1)=1;  
                newsolution(d,2)=2+sumrand;
               
            else
                newsolution(d,1)=HSAM(d,(2*birand)-1)-randint(1,1,[1,mindist]);    
                newsolution(d,2)=HSAM(d,(2*birand))+randint(1,1,[1,mindist]);     
                if newsolution(d,1)<0   | newsolution(d,1)==0      
                    newsolution(d,1)=1; 
                end
                if newsolution(d,2)>MX(d)    
                    newsolution(d,2)=MX(d);
                end
            end

        elseif randnmrs<NMRS  %%%%%% no milk run shipment (usual) %%%%%%  
            display('no milk run shipment (usual)')   
            newsolution(d,1)=HSAM(d,(2*birand)-1)+floor((HSAM(d,(2*birand))-HSAM(d,(2*birand)-1))/2);       
            newsolution(d,2)=newsolution(d,1);      
           
        else   %%%%%% ordinary + milk run shipment %%%%%%         
            hsrand=rand;
            newsolution(d,1)=1; 
            
            if hsrand<HMCR  
                sumrand2=randint(1,1,[1,dist]);               
                rnd12=rand;rndpar=rand;
                       
                if rndpar<PAR          
                    display('ordinary --> Pitch Adjustment') 
                    
                    if rnd12<0.5        
                        newsolution(d,2)=HSAM(d,(2*birand))-sumrand2;       
                        if newsolution(d,2)<2      
                            newsolution(d,2)=2;     
                        end
                        
                    else
                        newsolution(d,2)=HSAM(d,(2*birand))+sumrand2;         
                        if newsolution(d,2)>MX(d)        
                            newsolution(d,2)=MX(d);       
                        end
                    end
                    
                else
                    display('ordinary --> No Pitching')       
                    newsolution(d,2)=HSAM(d,(2*birand));     
                end

            else     
                display('ordinary --> Random')                      
                newsolution(d,2)=randint(1,1,[2,MX(d)]);

            end
        end
    end
end

newsolution
MR2=[0];LP=zeros(V1,V3); 
for d=1:V3
    
    MR=MRtotal(1:MX(d),((d*3)-2):(((d*3)-2)+2));
    
    if newsolution(d,1)==newsolution(d,2)
        stt=10000000000000000000;fin=10000000000000000000;
    else
        stt=newsolution(d,1);fin=newsolution(d,2);  
    end
        
    j=0;
    for a=stt:fin
        
        if stt==10000000000000000000 & fin==10000000000000000000
            break
        end
        
        if sum(MR(a:fin,3))==0
            break
        end
        
        nesh=0;
        if MR(a,3)==1
            nesh=1;
            j=j+1;
            ex=[MR(a,1),MR(a,2)];
            
            LP(MR(a,1),d)=1;LP(MR(a,2),d)=1;
            
            jam=S(ex(1),d)+S(ex(2),d);
            MR(a,d)=j+(d*1000);
            for b=stt:fin
                if (MR(b,1)==ex(2)&MR(b,2)==ex(1)) | MR(b,1)==ex(1) | MR(b,2)==ex(2)
                    MR(b,3)=0;
                end
            end
            
            for b=stt:fin
                ind=0;sz=size(ex);
                if (MR(b,1)==ex(sz(2))&MR(b,2)==ex(1)) | MR(b,1)==ex(1) | MR(b,2)==ex(sz(2))
                    MR(b,3)=0;
                end
                if MR(b,3)==1 & MR(b,1)==ex(sz(2))
                    if S(MR(b,2),d)+jam<=A 
                        MR(b,3)=j+(d*1000);
                        jam=jam+S(MR(b,2),d);
                        ex2=[MR(b,1),MR(b,2)];ind=2;
                        
                        LP(MR(b,1),d)=1;LP(MR(b,2),d)=1;
                        
                        for e=stt:fin
                            if (MR(e,1)==ex2(2)&MR(e,2)==ex2(1)) | MR(e,1)==ex2(1) | MR(e,2)==ex2(2)
                                MR(e,3)=0;
                            end
                        end
                    else
                        MR(b,3)=0;
                    end
                elseif MR(b,3)==1 & MR(b,2)==ex(1)
                    if S(MR(b,1),d)+jam<=A 
                        MR(b,3)=j+(d*1000);
                        jam=jam+S(MR(b,1),d);
                        ex3=[MR(b,1),MR(b,2)];ind=3;
                        
                        LP(MR(b,1),d)=1;LP(MR(b,2),d)=1;
                        
                        for e=stt:fin
                            if (MR(e,1)==ex3(2)&MR(e,2)==ex3(1)) | MR(e,1)==ex3(1) | MR(e,2)==ex3(2)
                                MR(e,3)=0;
                            end
                        end
                    else
                        MR(b,3)=0;
                    end
                end
                if ind==2
                    ex=[ex,MR(b,2)];
                elseif ind==3
                    ex=[MR(b,1),ex];
                end
            end 
        end
        if nesh==1
            MR2=[MR2,j+(d*1000),ex];
            siz=size(ex);
            for f=a+1:MX(d)
                if MR(f,1)==ex(siz(2)) | MR(f,2)==ex(1)
                    MR(f,3)=0;
                end
            end
        end
    end
end
MR2(1)=[];

MR3=MR2;
szm=size(MR2);
if szm~=0
    for sh1=1:szm(2)
        if MR2(sh1)>1000
            sh2=sh1+1;
            while MR2(sh2)<1000
                if sh2==szm(2)
                    break
                end
                sh2=sh2+1;
            end
             if sh2==szm(2)& C(MR2(sh1+1),V1+floor(MR2(sh1)/1000))<C(MR2(sh2),V1+floor(MR2(sh1)/1000))
                ch1=MR2(sh1+1);
                ch2=MR2(sh2);
                MR3(sh1+1)=ch2;
                MR3(sh2)=ch1;
             elseif C(MR2(sh1+1),V1+floor(MR2(sh1)/1000))<C(MR2(sh2-1),V1+floor(MR2(sh1)/1000))
                ch1=MR2(sh1+1);
                ch2=MR2(sh2-1);
                MR3(sh1+1)=ch2;
                MR3(sh2-1)=ch1;
            end
        end
    end
end
MR3
LP

COST_DS=[0];COST_CD=[0];COST_MR=[0];PS_CD=zeros(V1,V2);CD_AP=zeros(V2,V3);
for a=1:V3
    for b=1:V1
        if LP(b,a)==0
            cip=[0];
            for e=1:V2
                cip=[cip,C1(b,e)+((S(b,a)/A)*C2(e,a))];
            end
            cip(1)=[];
            [p,q]=sort(cip);
            if p(1)<C(b,a+V1)
                LP(b,a)=2000+q(1);
                
                PS_CD(b,q(1))=PS_CD(b,q(1))+S(b,a);
                CD_AP(q(1),a)=CD_AP(q(1),a)+S(b,a);
                
            else
                LP(b,a)=3;
                
                COST_DS=[COST_DS,C(b,a+V1)];
                
            end
        end
    end
end
LP

fn=find(MR3>1000);
szfn=size(fn);
szmr=size(MR3);
MR3_R=MR3;
if szmr~=0
    for a=1:szfn(2)-1
        MR3_R(fn(a+1))=MR3(fn(a));
    end
    MR3_R=[MR3_R,MR3(fn(szfn(2)))];
    MR3_R(1)=[];
    
    for a=1:szmr(2)-1
        if MR3_R(a)<1000 & MR3_R(a+1)<1000
            COST_MR=[COST_MR,C(MR3_R(a),MR3_R(a+1))];
        elseif MR3_R(a)<1000 & MR3_R(a+1)>1000
            COST_MR=[COST_MR,C(MR3_R(a),V1+floor(MR3_R(a+1)/1000))];
        end
    end
end
MR3_R;

PS_CD;M=PS_CD;
CD_AP;N=CD_AP;

if sum(sum(PS_CD))~=0
    for a=1:V1*V2
        if PS_CD(a)~=0
            M(a)=floor(PS_CD(a)/A)+1;
            
            COST_CD=[COST_CD,M(a)*C1(a)];
            
        end
    end
end
if sum(sum(CD_AP))~=0
    for b=1:V2*V3
        if CD_AP(b)~=0
            N(b)=floor(CD_AP(b)/A)+1;
            
            COST_CD=[COST_CD,N(b)*C2(b)];
            
        end
    end
end
M;N;

sum(COST_DS);sum(COST_CD);sum(COST_MR);COST=sum(COST_DS)+sum(COST_CD)+sum(COST_MR);SUBCOST=sum(COST_DS)+sum(COST_CD);
display(['The cost of MR tips of new solution: ',num2str(sum(COST_MR))])
display(['The cost of DIRECT & INDIRECT shipments of new solution before SA: ',num2str(SUBCOST)])
display(['The TOTAL cost of new solution before SA: ',num2str(COST)])

BEST_SUBCOST=SUBCOST;
BEST_M=M;BEST_N=N;BEST_LP=LP;
S_SUBCOST=[0];S_SUBCOST=[S_SUBCOST,SUBCOST]; 


%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ Simulated Annealing $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

for SAI=1:sai
    for LL=1:ll
        %We want to make a neighbour matrix for LP randomly in a way that MR trips do not change (for using in the SA)
        LPnew=LP;
        for e=1:V3
            cds=[0];
            for f=1:V1
                if LP(f,e)>1
                    cds=[cds;f];
                end
            end
            cds(1)=[];
            szcds=size(cds);
            if szcds(1)~=0
                rnd1=randint(1,1,[1,szcds(1)]);
                if LP(cds(rnd1),e)==3 %Direct Shipment
                    rnd2=randint(1,1,[1,V2]);
                    LPnew(cds(rnd1),e)=2000+rnd2;
                else   %Shipment through CD
                    bagh=LP(cds(rnd1),e)-2000;
                    rnd3=randint(1,1,[1,V2+1]);
                    while rnd3==bagh
                        rnd3=randint(1,1,[1,V2+1]);
                    end
                    if rnd3==V2+1
                        LPnew(cds(rnd1),e)=3;
                    else
                        LPnew(cds(rnd1),e)=2000+rnd3;
                    end
                end
            end           
        end
        LPnew;  %New LP with the same MR trips

        % We want to calculate the cost of new LP. NOTICE: COST_MR has NOT changed
        COST_DSnew=[0];COST_CDnew=[0];PS_CDnew=zeros(V1,V2);CD_APnew=zeros(V2,V3);
        for a=1:V3
            for b=1:V1
                if LPnew(b,a)>2000
                    e=LPnew(b,a)-2000; % e shows the CDe
                    PS_CDnew(b,e)=PS_CDnew(b,e)+S(b,a);
                    CD_APnew(e,a)=CD_APnew(e,a)+S(b,a);   
                elseif LPnew(b,a)==3
                    COST_DSnew=[COST_DSnew,C(b,a+V1)];  
                end
            end
        end

        Mnew=PS_CDnew;
        Nnew=CD_APnew;
        if sum(sum(PS_CDnew))~=0
            for a=1:V1*V2
                if PS_CDnew(a)~=0
                    Mnew(a)=floor(PS_CDnew(a)/A)+1;
                    COST_CDnew=[COST_CDnew,Mnew(a)*C1(a)];
                end
            end
        end
        if sum(sum(CD_APnew))~=0
            for b=1:V2*V3
                if CD_APnew(b)~=0
                    Nnew(b)=floor(CD_APnew(b)/A)+1;
                    COST_CDnew=[COST_CDnew,Nnew(b)*C2(b)];
                end
            end
        end
        Mnew;Nnew;
        %COST_MR has NOT changed!
        sum(COST_DSnew);sum(COST_CDnew);sum(COST_MR);SUBCOSTnew=sum(COST_DSnew)+sum(COST_CDnew);
        
        if SUBCOSTnew<BEST_SUBCOST
            BEST_SUBCOST=SUBCOSTnew;
            BEST_M=Mnew;BEST_N=Nnew;BEST_LP=LPnew;
        end
        
        if SUBCOSTnew<SUBCOST
            LP=LPnew;
            SUBCOST=SUBCOSTnew;
            %display('LP has changed')
        elseif SUBCOSTnew>SUBCOST
            if rand<exp(-(SUBCOSTnew-SUBCOST)/T(SAI))
                LP=LPnew;
                SUBCOST=SUBCOSTnew;
                %display('LP has changed')
            end
        end

        S_SUBCOST=[S_SUBCOST,SUBCOST];
        
        
    end
end

display('----------------------------------------------------------------------------')
display('The best LP of new solution after SA:')
BEST_LP
display(['The best cost of DIRECT & INDIRECT shipments of new solution after SA: ',num2str(BEST_SUBCOST)])

S_SUBCOST(1)=[];
%figure(5)
%plot(S_SUBCOST)
xlabel('Iteration')
ylabel('Cost')
title('Changes of the cost of Direct & Indirect shipments of new solution during the SA algorithm')

FF=sum(COST_MR)+BEST_SUBCOST;
display(['The TOTAL cost of new solution after SA: ',num2str(FF)])

%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ end of Simulated Annealing $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

[m,n]=sort(S_FF);
if FF<S_FF(n(20))
    display('VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV')
    display('Population (matrix HSAM) has been bettered through changing in matrix MRtotal range and order:')
    copcounter=copcounter+1;
    S_FF(n(20))=FF;
    display(['The new solution has entered matrix HSAM in column: ',num2str(n(20))])
    for d=1:V3 % matrix HSAM must be modified
        HSAM(d,2*n(20)-1)=newsolution(d,1);
        HSAM(d,2*n(20))=newsolution(d,2);
    end
    HSAM(V3+1,2*n(20)-1)=FF;HSAM(V3+1,2*n(20))=FF;
    display('HSAM has changed')
    HSAM
    FF_plot=[FF_plot;FF];
    
else
    display('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX')
    display('Population (matrix HSAM) has not changed')
    szpl=size(FF_plot);
    FF_plot=[FF_plot;FF_plot(szpl(1))];
    
    MRtotal=MRtotaloriginal;
    
end

if FF<BEST_FF
    display('$$$$$$$$$$$$$$$$$$$$$$$$$$')
    display('Best solution has changed')
    BEST_FF=FF;
    GLOBALBEST_LP=BEST_LP;
    BEST_MR=MR3;
    BEST_COST_MR=sum(COST_MR);
    GLOBALBEST_SUBCOST=BEST_SUBCOST;
    
end

    figure(2)
    plot(FF_plot)
    xlabel('Iteration')
    ylabel('Cost')
    title('Changes of the COST of NEW SOLUTIONs entering the population')
    
    AVERAGE=[AVERAGE;sum(S_FF)/20];
    
% ################################################################# END OF PHASE TWO 2 ###########################################################    
                     
    display('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++')
end

    figure(3)
    plot(AVERAGE)
    xlabel('Iteration')
    ylabel('Cost')
    title('Changes of AVERAGE COST of each population during the algorithm')


display('==================================================================================================================================================================')
toc
display(['The number of iterations implemented for making a new solution for population: ',num2str(iteration)])
display(['The number of population changes: ',num2str(copcounter)])
display(['The best solution of first population: ',num2str(bestfirstpopulation)])
display(['The cost of NoMilkRun solution: ',num2str(costantimilkrun)])
if bfp==0
    display('The best cost of initial population is related to NoMilkRun shipment ')
else
    display('The best cost of initial population is related to a MilkRun shipment')
end
display(['The cost of BEST solution: ',num2str(BEST_FF)])
HSAM
sort(S_FF)
GLOBALBEST_LP
GLOBALBEST_SUBCOST
BEST_MR
BEST_COST_MR
BEST_FF
MRtotal;

display ('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ THE END $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$')

