# Container for bank group type values.
module Spree::PAYONE
  module Utils
    class BankGroupType
      # Bank group type values
      ARZ_OVB = 'ARZ_OVB'
      ARZ_BAF = 'ARZ_BAF'
      ARZ_NLH = 'ARZ_NLH'
      ARZ_VLH = 'ARZ_VLH'
      AGARZ_BCS = 'AGARZ_BCS'
      ARZ_HTB = 'ARZ_HTB'
      ARZ_HAA = 'ARZ_HAA'
      ARZ_IKB = 'ARZ_IKB'
      ARZ_OAB = 'ARZ_OAB'
      ARZ_IMB = 'ARZ_IMB'
      ARZ_GRB = 'ARZ_GRB'
      ARZ_HIB = 'ARZ_HIB'
      BA_AUS = 'BA_AUS'
      BAWAG_BWG = 'BAWAG_BWG'
      BAWAG_PSK = 'BAWAG_PSK'
      BAWAG_ESY = 'BAWAG_ESY'
      BAWAG_SPD = 'BAWAG_SPD'
      SPARDAT_EBS = 'SPARDAT_EBS'
      SPARDAT_BBL = 'SPARDAT_BBL'
      RAC_RAC = 'RAC_RAC'
      HRAC_OOS = 'HRAC_OOS'
      HRAC_SLB = 'HRAC_SLB'
      HRAC_STM = 'HRAC_STM'
      ABN_AMRO_BANK = 'ABN_AMRO_BANK'
      RABOBANK = 'RABOBANK'
      FRIESLAND_BANK = 'FRIESLAND_BANK'
      ASN_BANK = 'ASN_BANK'
      SNS_BANK = 'SNS_BANK'
      TRIODOS_BANK = 'TRIODOS_BANK'
      SNS_REGIO_BANK = 'SNS_REGIO_BANK'
      ING_BANK = 'ING_BANK'
      
      # Bank group type symbol values
      ARZ_OVB_SYMBOL = :bank_group_type_arz_ovb
      ARZ_BAF_SYMBOL = :bank_group_type_arz_baf
      ARZ_NLH_SYMBOL = :bank_group_type_arz_nlh
      ARZ_VLH_SYMBOL = :bank_group_type_arz_vlh
      AGARZ_BCS_SYMBOL = :bank_group_type_agarz_bcs
      ARZ_HTB_SYMBOL = :bank_group_type_arz_htb
      ARZ_HAA_SYMBOL = :bank_group_type_arz_haa
      ARZ_IKB_SYMBOL = :bank_group_type_arz_ikb
      ARZ_OAB_SYMBOL = :bank_group_type_arz_oab
      ARZ_IMB_SYMBOL = :bank_group_type_arz_imb
      ARZ_GRB_SYMBOL = :bank_group_type_arz_grb
      ARZ_HIB_SYMBOL = :bank_group_type_arz_hib
      BA_AUS_SYMBOL = :bank_group_type_ba_aus
      BAWAG_BWG_SYMBOL = :bank_group_type_bawag_bwg
      BAWAG_PSK_SYMBOL = :bank_group_type_bawag_psk
      BAWAG_ESY_SYMBOL = :bank_group_type_bawag_esy
      BAWAG_SPD_SYMBOL = :bank_group_type_bawag_spd
      SPARDAT_EBS_SYMBOL = :bank_group_type_spardat_ebs
      SPARDAT_BBL_SYMBOL = :bank_group_type_spardat_bbl
      RAC_RAC_SYMBOL = :bank_group_type_rac_rac
      HRAC_OOS_SYMBOL = :bank_group_type_hrac_oos
      HRAC_SLB_SYMBOL = :bank_group_type_hrac_slb
      HRAC_STM_SYMBOL = :bank_group_type_hrac_stm
      ABN_AMRO_BANK_SYMBOL = :bank_group_type_abn_amro_bank
      RABOBANK_SYMBOL = :bank_group_type_rabobank
      FRIESLAND_BANK_SYMBOL = :bank_group_type_friesland_bank
      ASN_BANK_SYMBOL = :bank_group_type_asn_bank
      SNS_BANK_SYMBOL = :bank_group_type_sns_bank
      TRIODOS_BANK_SYMBOL = :bank_group_type_triodos_bank
      SNS_REGIO_BANK_SYMBOL = :bank_group_type_sns_regio_bank
      ING_BANK_SYMBOL = :bank_group_type_ing_bank
      
      # Validates bank group type and returns PAYONE specific code.
      def self.validate(type)
        type = type.to_s.downcase
        if type =~ /^arz_ovb$/
          return self::ARZ_OVB
        elsif type =~ /^arz_baf$/
          return self::ARZ_BAF
        elsif type =~ /^arz_nlh$/
          return self::ARZ_NLH
        elsif type =~ /^arz_vlh$/
          return self::ARZ_VLH
        elsif type =~ /^agarz_bcs$/
          return self::AGARZ_BCS
        elsif type =~ /^arz_htb$/
          return self::ARZ_HTB
        elsif type =~ /^arz_haa$/
          return self::ARZ_HAA
        elsif type =~ /^arz_ikb$/
          return self::ARZ_IKB
        elsif type =~ /^arz_oab$/
          return self::ARZ_OAB
        elsif type =~ /^arz_imb$/
          return self::ARZ_IMB
        elsif type =~ /^arz_grb$/
          return self::ARZ_GRB
        elsif type =~ /^arz_hib$/
          return self::ARZ_HIB
        elsif type =~ /^ba_aus$/
          return self::BA_AUS
        elsif type =~ /^bawag_bwg$/
          return self::BAWAG_BWG
        elsif type =~ /^bawag_psk$/
          return self::BAWAG_PSK
        elsif type =~ /^bawag_esy$/
          return self::BAWAG_ESY
        elsif type =~ /^bawag_spd$/
          return self::BAWAG_SPD
        elsif type =~ /^spardat_ebs$/
          return self::SPARDAT_EBS
        elsif type =~ /^spardat_bbl$/
          return self::SPARDAT_BBL
        elsif type =~ /^rac_rac$/
          return self::RAC_RAC
        elsif type =~ /^hrac_oos$/
          return self::HRAC_OOS
        elsif type =~ /^hrac_slb$/
          return self::HRAC_SLB
        elsif type =~ /^hrac_stm$/
          return self::HRAC_STM
        elsif type =~ /^abn_amro_bank$/
          return self::ABN_AMRO_BANK
        elsif type =~ /^rabobank$/
          return self::RABOBANK
        elsif type =~ /^friesland_bank$/
          return self::FRIESLAND_BANK
        elsif type =~ /^asn_bank$/
          return self::ASN_BANK
        elsif type =~ /^sns_bank$/
          return self::SNS_BANK
        elsif type =~ /^triodos_bank$/
          return self::TRIODOS_BANK
        elsif type =~ /^sns_regio_bank$/
          return self::SNS_REGIO_BANK
        elsif type =~ /^ing_bank$/
          return self::ING_BANK
        else
          nil
        end
      end
      
      # Validates bank group type and returns symbol.
      def self.validate_symbol(type)
        case self.validate(type)
          when self::ARZ_OVB
            return self::ARZ_OVB_SYMBOL
          when self::ARZ_BAF
            return self::ARZ_BAF_SYMBOL
          when self::ARZ_NLH
            return self::ARZ_NLH_SYMBOL
          when self::ARZ_VLH
            return self::ARZ_VLH_SYMBOL
          when self::AGARZ_BCS
            return self::AGARZ_BCS_SYMBOL
          when self::ARZ_HTB
            return self::ARZ_HTB_SYMBOL
          when self::ARZ_HAA
            return self::ARZ_HAA_SYMBOL
          when self::ARZ_IKB
            return self::ARZ_IKB_SYMBOL
          when self::ARZ_OAB
            return self::ARZ_OAB_SYMBOL
          when self::ARZ_IMB
            return self::ARZ_IMB_SYMBOL
          when self::ARZ_GRB
            return self::ARZ_GRB_SYMBOL
          when self::ARZ_HIB
            return self::ARZ_HIB_SYMBOL
          when self::BA_AUS
            return self::BA_AUS_SYMBOL
          when self::BAWAG_BWG
            return self::BAWAG_BWG_SYMBOL
          when self::BAWAG_PSK
            return self::BAWAG_PSK_SYMBOL
          when self::BAWAG_ESY
            return self::BAWAG_ESY_SYMBOL
          when self::BAWAG_SPD
            return self::BAWAG_SPD_SYMBOL
          when self::SPARDAT_EBS
            return self::SPARDAT_EBS_SYMBOL
          when self::SPARDAT_BBL
            return self::SPARDAT_BBL_SYMBOL
          when self::RAC_RAC
            return self::RAC_RAC_SYMBOL
          when self::HRAC_OOS
            return self::HRAC_OOS_SYMBOL
          when self::HRAC_SLB
            return self::HRAC_SLB_SYMBOL
          when self::HRAC_STM
            return self::HRAC_STM_SYMBOL
          when self::ABN_AMRO_BANK
            return self::ABN_AMRO_BANK_SYMBOL
          when self::RABOBANK
            return self::RABOBANK_SYMBOL
          when self::FRIESLAND_BANK
            return self::FRIESLAND_BANK_SYMBOL
          when self::ASN_BANK
            return self::ASN_BANK_SYMBOL
          when self::SNS_BANK
            return self::SNS_BANK_SYMBOL
          when self::TRIODOS_BANK
            return self::TRIODOS_BANK_SYMBOL
          when self::SNS_REGIO_BANK
            return self::SNS_REGIO_BANK_SYMBOL
          when self::ING_BANK
            return self::ING_BANK_SYMBOL
          else
            return nil
        end
      end
      
      # Returns all values array.
      def self.list()
        [self::ARZ_OVB, self::ARZ_BAF, self::ARZ_NLH, self::ARZ_VLH,
         self::AGARZ_BCS, self::ARZ_HTB, self::ARZ_HAA, self::ARZ_IKB,
         self::ARZ_OAB, self::ARZ_IMB, self::ARZ_GRB, self::ARZ_HIB,
         self::BA_AUS, self::BAWAG_BWG, self::BAWAG_PSK, self::BAWAG_ESY,
         self::BAWAG_SPD, self::SPARDAT_EBS, self::SPARDAT_BBL, self::RAC_RAC,
         self::HRAC_OOS, self::HRAC_SLB, self::HRAC_STM, self::ABN_AMRO_BANK,
         self::RABOBANK, self::FRIESLAND_BANK, self::ASN_BANK, self::SNS_BANK,
         self::TRIODOS_BANK, self::SNS_REGIO_BANK, self::ING_BANK]
      end
      
      # Returns all values array for EPS.
      def self.eps_list()
        [self::ARZ_OVB, self::ARZ_BAF, self::ARZ_NLH, self::ARZ_VLH,
         self::AGARZ_BCS, self::ARZ_HTB, self::ARZ_HAA, self::ARZ_IKB,
         self::ARZ_OAB, self::ARZ_IMB, self::ARZ_GRB, self::ARZ_HIB,
         self::BA_AUS, self::BAWAG_BWG, self::BAWAG_PSK, self::BAWAG_ESY,
         self::BAWAG_SPD, self::SPARDAT_EBS, self::SPARDAT_BBL, self::RAC_RAC,
         self::HRAC_OOS, self::HRAC_SLB, self::HRAC_STM]
      end
      
      # Returns all values array for IDL.
      def self.idl_list()
        [self::ABN_AMRO_BANK, self::RABOBANK, self::FRIESLAND_BANK, self::ASN_BANK,
         self::SNS_BANK, self::TRIODOS_BANK, self::SNS_REGIO_BANK, self::ING_BANK]
      end
    end
  end
end