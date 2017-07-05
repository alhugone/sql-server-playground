using System;
using System.Data.SqlClient;
using NUnit.Framework;

namespace ForXmlStreamingTests
{
    public class ForXmlStreamingTests
    {
        private SqlCommand _cmd;
        private SqlConnection _connection;

        [SetUp]
        public void SetUp()
        {
            _connection = new SqlConnection(new SqlConnectionStringBuilder
            {
                DataSource = ".\\SQLEXPRESS",
                IntegratedSecurity = true
            }.ToString());
            _connection.Open();
            _cmd = _connection.CreateCommand();
        }

        [TearDown]
        public void TearDown()
        {
            _connection.Close();
        }

        [Test]
        public void ForXml_With_Type_Option_Returns_Result_As_Xml_Type_In_OneRow()
        {
            //arrange
            _cmd.CommandText =
                $"select REPLICATE('a', 6000) as [T] for xml raw, type";
            var reader = _cmd.ExecuteReader();
            var readCount = 0;
            //act
            while (reader.Read())
            {
                readCount++;
            }
            //assert
            Assert.AreEqual("xml", reader.GetDataTypeName(0));
            Assert.AreEqual(1, readCount);
        }

        [Test]
        [TestCase(1000)]
        [TestCase(2000)]
        [TestCase(2033)]
        public void
            When_XmlString_Length_Is_LessThanOrEqualTo_2033_ForXml_Without_Type_Option_Returns_Result_As_ntext_Type_In_1_Row
            (int returnedXmlLength)
        {
            var additionLength = "<row T=''/>".Length;
            //arrange
            _cmd.CommandText =
                $"select REPLICATE('a', {returnedXmlLength - additionLength}) as [T] for xml raw";
            var reader = _cmd.ExecuteReader();
            var readCount = 0;
            var xmlLength = 0;
            //act
            while (reader.Read())
            {
                xmlLength += reader.GetSqlString(0).Value.Length;
                readCount++;
            }
            //assert
            Assert.AreEqual("ntext", reader.GetDataTypeName(0));
            Assert.AreEqual(1, readCount);
            Assert.AreEqual(returnedXmlLength, xmlLength);
        }

        [Test]
        [TestCase(2034)]
        [TestCase(3452)]
        [TestCase(4066)]
        public void
            When_XmlString_Length_Is_GreaterThan_2033_And_LessThan_4067_ForXml_Without_Type_Option_Returns_Result_As_ntext_Type_In_2_Rows
            (int returnedXmlLength)
        {
            var additionLength = "<row T=''/>".Length;
            //arrange
            _cmd.CommandText =
                $"select REPLICATE('a', {returnedXmlLength - additionLength}) as [T] for xml raw";
            var reader = _cmd.ExecuteReader();
            var readCount = 0;
            var xmlLength = 0;
            //act
            while (reader.Read())
            {
                xmlLength += reader.GetSqlString(0).Value.Length;
                readCount++;
            }
            //assert
            Assert.AreEqual("ntext", reader.GetDataTypeName(0));
            Assert.AreEqual(2, readCount);
            Assert.AreEqual(returnedXmlLength, xmlLength);
        }

        [Test]
        [TestCase(1000)]
        [TestCase(2033)]
        [TestCase(2034)]
        [TestCase(2034)]
        [TestCase(2034)]
        [TestCase(2034)]
        public void
            ForXml_Without_Type_Option_Split_XmlStringResult_Into_Packages_Of_2033_MaxLength_That_Are_Send_As_Spearated_Rows
            (int returnedXmlLength)
        {
            var additionLength = "<row T=''/>".Length;
            //arrange
            _cmd.CommandText =
                $"select REPLICATE('a', {returnedXmlLength - additionLength}) as [T] for xml raw";
            var reader = _cmd.ExecuteReader();
            var readCount = 0;
            var xmlLength = 0;
            //act
            while (reader.Read())
            {
                xmlLength += reader.GetSqlString(0).Value.Length;
                readCount++;
            }
            //assert
            Assert.AreEqual("ntext", reader.GetDataTypeName(0));
            Assert.AreEqual(Math.Ceiling(returnedXmlLength/2033.0), readCount);
            Assert.AreEqual(returnedXmlLength, xmlLength);
        }

        [Test]
        public void XmlReader_Handles_ForXml_Streaming_By_Reading_AllAtOnce()
        {
            //arrange
            _cmd.CommandText =
                $"select REPLICATE('a', 6000) as [T] for xml raw, type";
            var reader = _cmd.ExecuteXmlReader();
            var readCount = 0;
            //act
            while (reader.Read())
            {
                readCount++;
            }
            //assert
            Assert.AreEqual(1, readCount);
        }
    }
}