function[sayi]=genetic_algorithm(sutun)


        durum=1;

        i=1;

        while durum==1

            sayi(i)=round(2+(sutun-2)*rand());

            if i~=1

                s=i;

                while s~=1

                    while sayi(s-1)==sayi(i)

                        sayi(i)=round(2+(sutun-2)*rand());

                        s=i;

                    end

                    s=s-1;

                end


            end

            if length(sayi)==sutun-1
                durum=0;

            end

            i=i+1;

        end

         %random say?lardan ayn?s?n?n bulunup

        %     bulunmad?g?n? kontrol eder

        for i=1:length(sayi)-1

            for j=i+1:length(sayi)

                if sayi(i)==sayi(j)

%                     'ayn? say? var, algoritma hatal?'

%                     i,j

                end

            end

        end

end