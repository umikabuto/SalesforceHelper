/****** Object:  UserDefinedFunction [dbo].[id15to18]    Script Date: 2022/05/21 15:28:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
ALTER FUNCTION [dbo].[id15to18] 
(
	@inputid nvarchar(15)
)
RETURNS nvarchar(18)
AS
BEGIN
	DECLARE @flags integer = 0
	DECLARE @suffix nvarchar(3) = ''
	DECLARE @chr nvarchar = NULL
	DECLARE @i integer = 0
	DECLARE @j integer = 0

    IF LEN(@inputid) != 15
	BEGIN
        RETURN @inputid
    END

	WHILE @i < 3
	BEGIN
		SET @flags = 0
		WHILE @j < 5
		BEGIN
			SET @chr = SUBSTRING(@inputId, @i * 5 + @j + 1, 1)
			IF (ASCII(@chr) >= ASCII('A')) AND (ASCII(@chr) <= ASCII('Z'))
			BEGIN
				IF @j = 0 BEGIN SET @flags = @flags + 1 END
				ELSE IF @j = 1 BEGIN SET @flags = @flags + 2 END
				ELSE IF @j = 2 BEGIN SET @flags = @flags + 4 END
				ELSE IF @j = 3 BEGIN SET @flags = @flags + 8 END
				ELSE IF @j = 4 BEGIN SET @flags = @flags + 16 END
			END
			SET @j = @j + 1
		END
		SET @suffix = @suffix + SUBSTRING('ABCDEFGHIJKLMNOPQRSTUVWXYZ012345', @flags + 1, 1)
		SET @i = @i + 1
		SET @j = 0
	END 
    RETURN @inputid + @suffix
END

